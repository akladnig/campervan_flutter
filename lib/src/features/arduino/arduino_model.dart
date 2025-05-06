import 'dart:convert';
import 'dart:core';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'arduino_model.g.dart';

enum Characteristics {
  temperature(
    label: 'temperature',
    units: '°C',
    icon: Icon(FontAwesomeIcons.temperatureThreeQuarters, size: Sizes.iconFA),
  ),
  voltage(label: 'voltage', units: 'V', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  amperage(label: 'amperage', units: 'A', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  percentage(label: 'percentage', units: '%', icon: Icon(Icons.percent, size: Sizes.icon)),
  kwH(label: 'kwH', units: 'kwH', icon: Icon(Icons.bolt, size: Sizes.icon)),
  switchState(label: '', units: '', icon: Icon(Icons.toggle_off, size: Sizes.icon)),
  flowRate(label: 'Flow Rate', units: 'l/min', icon: Icon(Icons.toggle_off, size: Sizes.icon));

  final String label;
  final String units;
  final Icon icon;

  const Characteristics({required this.label, required this.units, required this.icon});
}

/// Devices that can be directly monitored either via circuitry or RS485
enum Devices {
  solarPanel1(label: 'Solar Panel 1'),
  solarPanel2(label: 'Solar Panel 2'),
  solarSwitchSensor(label: 'Solar Switch Sensor'),
  starterBattery(label: 'Starter Battery'),
  battery1in(label: 'Battery 1 in'),
  battery2in(label: 'Battery 2 in'),
  battery1out(label: 'Battery 1 out'),
  battery2out(label: 'Battery 2 out'),
  dcdc20A(label: 'DC-DC 20A'),
  battery2Switch(label: 'Battery 2 Switch'),
  ambientTemperature(label: 'Ambient Temperature'),
  batteryBoxTemperature(label: 'Battery Box Temperature'),
  duoettoTemperature(label: 'Duoetto Temperature'),
  inputFlowSensor(label: 'Input Flow Sensor'),
  outputFlowSensor(label: 'Output Flow Sensor');

  final String label;
  const Devices({required this.label});
}

enum BleDevices { battery1Ble, battery2Ble, dcdc50ABle }

enum Controls { solarSwitch, powerOnOff, battery2, batteryBoxFan, ledLights, siroccoFan }

class Device {
  final Devices device;
  final Map<Characteristics, double> characteristics;

  Device(this.device, this.characteristics);

  update(characteristic, value) {
    characteristics[characteristic] = value;
  }

  @override
  toString() {
    var str = 'Device: ${device.label}\n';

    for (final i in characteristics.entries) {
      str += '${i.key}: ${i.value.toString()}\n';
    }
    return str;
  }
}

typedef Characteristic = Map<Characteristics, double>;

typedef D = Devices;
typedef C = Characteristics;

/// A map of all monitored devices and their characteristics.
/// The characteristic values are updated by the arduinoWebSocketProvider
@Riverpod(keepAlive: true)
class DeviceMap extends _$DeviceMap {
  final deviceMap = IMap({
    D.solarSwitchSensor: IMap({C.switchState: 0.0}),
    D.starterBattery: IMap({C.voltage: 0.0}),
    D.battery1in: IMap({C.voltage: 0.0}),
    D.battery2in: IMap({C.voltage: 0.0}),
    D.battery1out: IMap({C.voltage: 0.0, C.amperage: 0.0}),
    D.battery2out: IMap({C.voltage: 0.0, C.amperage: 0.0}),
    D.dcdc20A: IMap({C.voltage: 0.0, C.amperage: 0.0}),
    D.battery2Switch: IMap({C.switchState: 0.0}),
    D.ambientTemperature: IMap({C.temperature: 0.0}),
    D.batteryBoxTemperature: IMap({C.temperature: 0.0}),
    D.duoettoTemperature: IMap({C.temperature: 0.0}),
    D.inputFlowSensor: IMap({C.flowRate: 0.0}),
    D.outputFlowSensor: IMap({C.flowRate: 0.0}),
  });

  @override
  IMap<Devices, IMap<Characteristics, double>> build() {
    ref.watch(arduinoWebSocketProvider);
    return deviceMap;
  }

  update(Devices device, Characteristics characteristic, double newValue) {
    state = state.update(device, (value) => IMap({characteristic: newValue}));
  }

  updateAll() {
    ref.watch(arduinoWebSocketProvider);
    // state = state.update(device, (value) => IMap({characteristic: newValue}));
  }
}

@Riverpod(keepAlive: true)
class ArduinoWebSocket extends _$ArduinoWebSocket {
  WebSocketChannel? channel;
  bool _isDisposed = false;

  @override
  Future<WebSocketChannel?> build() async {
    if (channel != null) return channel;

    await connect();
    return channel;
  }

  Future<WebSocketChannel> connect() async {
    /// Create the WebSocket channel
    final myWsUrl = 'KladderVan';
    channel = WebSocketChannel.connect(Uri.parse(myWsUrl));

    await channel?.ready;
    return channel!;
  }

  void send(String message) {
    channel?.sink.add(message);
  }

  void listen() {
    if (_isDisposed) return;

    channel?.stream.listen(
      (data) {
        final jsonData = jsonDecode(data) as Map<String, double>;
      },
      onError: (e) {
        reconnect();
      },
    );
  }

  void reconnect() {
    if (_isDisposed) return;

    Future.delayed(const Duration(seconds: 3), () {
      connect();
    });
  }

  void close() {
    _isDisposed = true;
    channel?.sink.close;
  }
}

import 'dart:core';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum IO { input, output, bidirectional, none }

//TODO - rpm, humidity, speed, brightness, motion detection
enum Characteristics {
  temperature(
    label: 'temperature',
    units: '°C',
    icon: Icon(FontAwesomeIcons.temperatureThreeQuarters, size: Sizes.iconFA),
  ),
  voltage(label: 'voltage', units: 'V', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  amperage(label: 'amperage', units: 'A', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  kwH(label: 'kwH', units: 'kwH', icon: Icon(Icons.bolt, size: Sizes.icon)),
  percentage(label: 'percentage', units: '%', icon: Icon(Icons.percent, size: Sizes.icon)),
  switchState(label: '', units: '', icon: Icon(Icons.toggle_off, size: Sizes.icon)),
  flowRate(label: 'Flow Rate', units: 'l/min', icon: Icon(Icons.toggle_off, size: Sizes.icon)),
  capacity(label: 'Volume', units: 'l', icon: Icon(Icons.propane_tank, size: Sizes.icon));

  final String label;
  final String units;
  final Icon icon;

  const Characteristics({required this.label, required this.units, required this.icon});
}

/// Devices used in the van with an ID hardcoded on the Arduino. This ID is used as the key in
/// json data sent from th Arduino.
enum Devices {
  // Solar Panels Module
  solarPanel1(id: '0x01', label: 'Solar Panel 1', io: IO.input),
  solarPanel2(id: '0x02', label: 'Solar Panel 2', io: IO.input),

  //Starter Battery Module
  starterBattery(id: '0x05', label: 'Starter Battery', io: IO.input),

  // Battery Box Module
  batteryBoxTemperature(id: '0x06', label: 'Battery Box Temperature', io: IO.input),
  batteryBoxFan(id: '0x07', label: 'Battery 1 in', io: IO.output),

  battery1in(id: '0x08', label: 'Battery 1 in', io: IO.input),
  battery2in(id: '0x09', label: 'Battery 2 in', io: IO.input),
  battery1out(id: '0x0A', label: 'Battery 1 out', io: IO.input),
  battery2out(id: '0x0B', label: 'Battery 2 out', io: IO.input),

  dcdc20A(id: '0x0C', label: 'DC-DC 20A', io: IO.input),
  dcdc50A(id: '0x0D', label: 'DC-DC 50A', io: IO.input),

  // Fuse and Switch Box Module
  powerSwitch(id: '0x0E', label: '12V power On/Off', io: IO.output),
  battery2Switch(id: '0x0F', label: 'Battery 2 On/Off', io: IO.bidirectional),
  solarSwitchSensor(id: '0x00', label: 'Solar Switch Sensor', io: IO.input),
  inverterFuseSwitchSensor(id: '0x11', label: 'Inverter Fuse and Switch Sensor', io: IO.input),
  pumpFuseSwitchSensor(id: '0x12', label: 'Pump Fuse and Switch Sensor', io: IO.input),
  fridgeFuseSwitchSensor(id: '0x13', label: 'Fridge Fuse and Switch Sensor', io: IO.input),
  lightsAuxFuseSwitchSensor(id: '0x14', label: 'Lights and Auxilliary Fuse and Switch Sensor', io: IO.input),
  // Lights and Auxilliary Module

  lightControl(id: '0x15', label: 'Light Control', io: IO.bidirectional),

  // Water System Module
  inputFlowSensor(id: '0x16', label: 'Input Flow Sensor', io: IO.input),
  outputFlowSensor(id: '0x17', label: 'Output Flow Sensor', io: IO.input),
  waterTank(id: '0x18', label: 'Water Tank', io: IO.none),
  duoettoTemperature(id: '0x19', label: 'Duoetto Temperature', io: IO.input),

  // Environment Module
  ambientTemperature(id: '0x20', label: 'Ambient Temperature', io: IO.input);

  final String id;
  final String label;
  final IO io;
  const Devices({required this.id, required this.label, required this.io});
}

enum BleDevices { battery1Ble, battery2Ble, dcdc50ABle }

enum Controls { solarSwitch, powerOnOff, battery2, batteryBoxFan, ledLights, siroccoFan }

class Device {
  final Devices device;
  final Map<Characteristics, double> characteristics;

  Device(this.device, this.characteristics);

  void update(Characteristics characteristic, double value) {
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
// @Riverpod(keepAlive: true)

class DeviceMap {
  // var deviceMap = IMap({
  //   D.solarSwitchSensor: IMap({C.switchState: 0.0}),
  //   D.starterBattery: IMap({C.voltage: 0.0}),
  //   D.battery1in: IMap({C.voltage: 0.0}),
  //   D.battery2in: IMap({C.voltage: 0.0}),
  //   D.battery1out: IMap({C.voltage: 0.0, C.amperage: 0.0}),
  //   D.battery2out: IMap({C.voltage: 0.0, C.amperage: 0.0}),
  //   D.dcdc20A: IMap({C.voltage: 0.0, C.amperage: 0.0}),
  //   D.battery2Switch: IMap({C.switchState: 0.0}),
  //   D.ambientTemperature: IMap({C.temperature: 0.0}),
  //   D.batteryBoxTemperature: IMap({C.temperature: 0.0}),
  //   D.duoettoTemperature: IMap({C.temperature: 0.0}),
  //   D.inputFlowSensor: IMap({C.flowRate: 0.0}),
  //   D.outputFlowSensor: IMap({C.flowRate: 0.0}),
  // });
  IMap<Devices, double> deviceMap = IMap();
  DeviceMap(this.deviceMap);

  factory DeviceMap.fromJson(Map<String, dynamic> json) {
    // IMap<Devices, IMap<Characteristics, double>> deviceMap = IMap();
    // IMap<Characteristic, double> characteristicMap = IMap();
    IMap<Devices, double> deviceMap = IMap();

    IMap<Devices, double> at = IMap({D.ambientTemperature: json[D.ambientTemperature.id] as double});
    IMap<Devices, double> bbt = IMap({D.batteryBoxTemperature: json[D.batteryBoxTemperature.id] as double});
    deviceMap = deviceMap.add(D.ambientTemperature, json[D.ambientTemperature.id] as double);
    deviceMap = deviceMap.add(D.batteryBoxTemperature, json[D.batteryBoxTemperature.id] as double);
    return DeviceMap(deviceMap);
  }

  @override
  String toString() {
    return deviceMap[D.ambientTemperature].toString();
  }
}

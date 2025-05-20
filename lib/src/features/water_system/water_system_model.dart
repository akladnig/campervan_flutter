import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:campervan/src/features/arduino/arduino_web_socket_provider.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'water_system_model.g.dart';

enum Modules {
  solarPanels(label: 'Solar Panels'),
  starterBattery(label: 'Starter Battery'),
  batteryBox(label: 'Battery Box'),
  fuseAndSwitchBox(label: 'Fuse and Switch Panel'),
  waterSystem(label: 'Water System');

  final String label;
  const Modules({required this.label});
}

typedef M = Modules;

/// A map of all monitored devices and their characteristics.
/// The characteristic values are updated by the arduinoWebSocketProvider
@Riverpod(keepAlive: true)
class ModuleMap extends _$ModuleMap {
  final IMap<Modules, ISet<Devices>> moduleMap = IMap({
    M.solarPanels: ISet({D.solarPanel1, D.solarPanel2}),
    M.starterBattery: ISet({D.starterBattery}),
    M.batteryBox: ISet({
      D.batteryBoxTemperature,
      D.batteryBoxFan,
      D.battery1in,
      D.battery2in,
      D.battery1out,
      D.battery2out,
      D.dcdc20A,
      D.dcdc50A,
    }),
    M.fuseAndSwitchBox: ISet({D.powerSwitch, D.battery2Switch, D.solarSwitchSensor}),
    M.waterSystem: ISet({D.inputFlowSensor, D.outputFlowSensor, D.waterTank, D.duoettoTemperature}),
  });

  @override
  IMap<Modules, ISet<Devices>> build() {
    ref.watch(arduinoWebSocketProvider);
    return moduleMap;
  }
}

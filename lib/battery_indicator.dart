
import 'dart:async';

import 'package:flutter/services.dart';

/// Comment by Anton Podolyanchik

class BatteryIndicator {
  static const MethodChannel _channel = MethodChannel('battery_indicator');
  static const String _getBatteryIndicatorMethod = 'get_battery_indicator';
  static const String _changeBatteryMethod = 'change_battery_indicator';

  final void Function(double value) _onBatteryPowerChanged;

  BatteryIndicator(this._onBatteryPowerChanged) {
    _initBatteryIndicator();
  }

  void _initBatteryIndicator() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case _changeBatteryMethod:
          _onBatteryPowerChanged(call.arguments);
          break;
      }
    });
  }

  Future<double> getBatteryIndicatorLevel() async {
    return await _channel.invokeMethod(_getBatteryIndicatorMethod);
  }
}

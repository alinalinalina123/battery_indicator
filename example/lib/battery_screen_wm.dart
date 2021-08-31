
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:battery_indicator/battery_indicator.dart';


class BatteryScreenWidgetModel extends WidgetModel {

  final batteryStateDownState = EntityStreamedState<BatteryState>();

  BatteryIndicator? batteryIndicator;
  BatteryState? currentState;
  
  @override
  void onLoad() {
    batteryIndicator = BatteryIndicator(_onBatteryPowerChanged);
    super.onLoad();
  }

  BatteryScreenWidgetModel(
      WidgetModelDependencies baseDependencies)
      : super(baseDependencies);

  static BatteryScreenWidgetModel builder(BuildContext context) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(),
    );
    return BatteryScreenWidgetModel(
      wmDependencies,
    );
  }


  BatteryState? _onBatteryPowerChanged(double value) {
    if (currentState == null) {
      currentState = BatteryState(currentLevel: value, previousLevel: value, isFirstStart: false);
    } else {
      currentState = currentState?.copyWith(currentLevel: value, previousLevel: currentState?.currentLevel);
    }
    if(currentState != null) {
      batteryStateDownState.content(currentState!);
    }
    return currentState;
  }
}

@immutable
class BatteryState {
  final double currentLevel;
  final double previousLevel;
  final bool isFirstStart;

  BatteryState({
    this.currentLevel = 100,
    this.previousLevel = 100,
    this.isFirstStart = true,
  });

  BatteryState copyWith({
    double? currentLevel,
    double? previousLevel,
    bool? isFirstStart,
  }) {
    return BatteryState(
      currentLevel: currentLevel ?? this.currentLevel,
      previousLevel: previousLevel ?? this.previousLevel,
      isFirstStart: isFirstStart ?? this.isFirstStart,
    );
  }
}

class StandardErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    e;
  }
}
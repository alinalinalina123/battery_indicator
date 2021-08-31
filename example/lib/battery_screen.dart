import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

import 'battery_screen_wm.dart';

class BatteryScreen extends CoreMwwmWidget<BatteryScreenWidgetModel> {
  const BatteryScreen({Key? key, WidgetModelBuilder? widgetModelBuilder})
      : super(key: key, widgetModelBuilder: BatteryScreenWidgetModel.builder);

  @override
  WidgetState<CoreMwwmWidget<BatteryScreenWidgetModel>,
      BatteryScreenWidgetModel> createWidgetState() {
    return _BatteryScreenState();
  }
}

class _BatteryScreenState
    extends WidgetState<BatteryScreen, BatteryScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: EntityStateBuilder<BatteryState>(
        streamedState: wm.batteryStateDownState,
        builder: (ctx, state){
          final snackBar = SnackBar(
            content: Text('Уровень заряда: ${state.currentLevel}'),
            backgroundColor: Theme.of(context).errorColor,
          );

          if (state.previousLevel > state.currentLevel) {
            if (state.currentLevel == 50 ||
                state.currentLevel == 40 ||
                state.currentLevel == 30 ||
                state.currentLevel == 20) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
          return Center(
            child: Text(
              'заряд  ${state.currentLevel.toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        },
      ),
    );
  }
}

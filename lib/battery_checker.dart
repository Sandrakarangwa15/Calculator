import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class BatteryChecker {
  final Battery _battery = Battery();
  Timer? _timer;

  void initialize(BuildContext context) {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        _startMonitoringBatteryLevel(context);
      } else {
        _stopMonitoringBatteryLevel();
      }
    });
  }

  void _startMonitoringBatteryLevel(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      int batteryLevel = await _battery.batteryLevel;
      if (batteryLevel == 90) {
        _showNotification(context);
        _stopMonitoringBatteryLevel();
      }
    });
  }

  void _stopMonitoringBatteryLevel() {
    _timer?.cancel();
  }

  void _showNotification(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Battery level reached 90%')),
    );

    // Play a sound
    final player = AudioCache();
    // await player.play('assets/sounds/notification.mp3');
  }
}

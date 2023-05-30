import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

class AlarmRing extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const AlarmRing({Key? key, required this.alarmSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "You alarm (${alarmSettings.id}) is ringing...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text("🔔", style: TextStyle(fontSize: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // RawMaterialButton(
                //   onPressed: () {
                //     final now = DateTime.now();
                //     Alarm.set(
                //       // 원래 시간 다시 설정
                //       alarmSettings: alarmSettings.copyWith(
                //         dateTime: DateTime(
                //           now.year,
                //           now.month,
                //           now.day,
                //           now.hour,
                //           now.minute,
                //           0,
                //           0,
                //         ).add(const Duration(days: 1)),
                //       ),
                //     ).then((_) => Navigator.pop(context));
                //     Alarm.set(
                //       // 원래 시간 다시 설정
                //       alarmSettings: alarmSettings.copyWith(
                //         dateTime: DateTime(
                //           now.year,
                //           now.month,
                //           now.day,
                //           now.hour,
                //           now.minute,
                //           0,
                //           0,
                //         ).add(const Duration(minutes: 5)),
                //       ),
                //     );
                //   },
                //   child: Text(
                //     "5분후 다시",
                //     style: Theme.of(context).textTheme.titleLarge,
                //   ),
                // ),
                RawMaterialButton(
                  onPressed: () {
                    final now = DateTime.now();
                    Alarm.set(
                      //다음날 다시 설정
                      alarmSettings: alarmSettings.copyWith(
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                        ).add(const Duration(days: 1)),
                      ),
                    ).then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "멈춤",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

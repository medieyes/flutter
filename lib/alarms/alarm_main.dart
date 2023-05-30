import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app/audioutill/audioUtil.dart';

import 'package:app/main.dart';
import 'package:alarm/alarm.dart';
import 'package:app/alarms/alarm_edit.dart';
import 'package:app/alarms/alarm_ring.dart';
import 'package:app/alarms/alarm_tile.dart';

class AlarmWidget extends StatefulWidget {
  const AlarmWidget({Key? key}) : super(key: key);

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlarmRing(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    AudioUtil.audioplay(); // 화면 전환 소리
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: AlarmEdit(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '복용 알람 ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ), textScaleFactor: 1.2,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AudioUtil.audioplay(); // 화면 전환 소리
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return AlarmTile(
                    key: Key(alarms[index].id.toString()),
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "알람 없음",
                  style: Theme.of(context).textTheme.titleMedium,
                  textScaleFactor: 1.5,
                ),
              ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[50],
        child: SizedBox(
          height: 56.0,
          child: ElevatedButton(
            //QR코드 검색 버튼 누르면 실행되는 기능
            onPressed: () => navigateToAlarmScreen(null),
            style: ElevatedButton.styleFrom(
                maximumSize: const Size(130, 130),
                // padding: const EdgeInsets.all(10),
                elevation: 0.0),
            child: const Text(
              '알람 설정',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.5,
            ),
          ),
        ),
      ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       // FloatingActionButton(
      //       //   onPressed: () {
      //       //     final alarmSettings = AlarmSettings(
      //       //       id: 42,
      //       //       dateTime: DateTime.now(),
      //       //       assetAudioPath:
      //       //           'https://github.com/sphy1597/test1/raw/master/pretender.mp3',
      //       //     );
      //       //     Alarm.set(alarmSettings: alarmSettings);
      //       //   },
      //       //   backgroundColor: Colors.red,
      //       //   heroTag: null,
      //       //   child: const Text("RING NOW", textAlign: TextAlign.center),
      //       // ),
      //       FloatingActionButton(
      //         onPressed: () => navigateToAlarmScreen(null),
      //         child: const Icon(Icons.alarm_add_rounded, size: 33),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

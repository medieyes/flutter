import 'package:flutter/material.dart';
import 'package:app/audioutill/audioUtil.dart';

import 'package:alarm/alarm.dart';

import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:time_picker_sheet/widget/sheet.dart';

class AlarmEdit extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmEdit({Key? key, this.alarmSettings}) : super(key: key);

  @override
  State<AlarmEdit> createState() => _AlarmEditState();
}

class _AlarmEditState extends State<AlarmEdit> {
  late bool creating;

  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool showNotification;
  late String assetAudio;

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      showNotification = true;
      assetAudio = 'https://github.com/sphy1597/test1/raw/master/pipi.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  Future<void> pickTime() async {
    AudioUtil.audioplay(); // 화면 전환 소리
    final res = await TimePicker.show(
        context: context,
        sheet: TimePickerSheet(
          minuteInterval: 1,
          sheetTitle: '시간설정',
          minuteTitle: '분',
          hourTitle: '시',
          saveButtonText: '저장',
          saveButtonColor: Colors.orange,
          sheetCloseIconColor: Colors.orange,
          hourTitleStyle: TextStyle(color: Colors.orange, fontSize: 22),
          minuteTitleStyle: TextStyle(color: Colors.orange, fontSize: 22),
          wheelNumberSelectedStyle:
              TextStyle(color: Colors.orange, fontSize: 24),
          wheelNumberItemStyle: TextStyle(fontSize: 20),
        ));
    if (res != null)
      setState(() {
        selectedTime = TimeOfDay(hour: res.hour, minute: res.minute);
      });
  }

  //  Future<void> pickTime() async {
  //   final res = await showTimePicker(
  //     initialTime: selectedTime,
  //     context: context,
  //   );
  //   if (res != null) setState(() => selectedTime = res);
  // }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      notificationTitle: showNotification ? 'Alarm example' : null,
      notificationBody: showNotification ? 'Your alarm ($id) is ringing' : null,
      assetAudioPath: assetAudio,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    AudioUtil.audioplay(); // 화면 전환 소리
    Alarm.set(alarmSettings: buildAlarmSettings())
        .then((_) => Navigator.pop(context, true));
  }

  Future<void> deleteAlarm() async {
    AudioUtil.audioplay(); // 화면 전환 소리
    Alarm.stop(widget.alarmSettings!.id)
        .then((_) => Navigator.pop(context, true));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => {
                  AudioUtil.audioplay(), // 화면 전환 소리
                  Navigator.pop(context, false)
                },
                child: Text(
                  "취소",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.orange),
                ),
              ),
              TextButton(
                onPressed: saveAlarm,
                child: Text(
                  "저장",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.orange),
                ),
              ),
            ],
          ),
          RawMaterialButton(
            onPressed: pickTime,
            fillColor: Colors.grey[200],
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                selectedTime.format(context),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.orange),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '알람 반복',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: loopAudio,
                onChanged: (value) => setState(() => loopAudio = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '진동',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: vibrate,
                onChanged: (value) => setState(() => vibrate = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '알람바',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: showNotification,
                onChanged: (value) => setState(() => showNotification = value),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Sound',
          //       style: Theme.of(context).textTheme.titleMedium,
          //     ),
          //     DropdownButton(
          //       value: assetAudio,
          //       items: const [
          //         DropdownMenuItem<String>(
          //           value: 'assets/mozart.mp3',
          //           child: Text('Mozart'),
          //         ),
          //         DropdownMenuItem<String>(
          //           value: 'assets/nokia.mp3',
          //           child: Text('Nokia'),
          //         ),
          //         DropdownMenuItem<String>(
          //           value: 'assets/one_piece.mp3',
          //           child: Text('One Piece'),
          //         ),
          //         DropdownMenuItem<String>(
          //           value: 'assets/star_wars.mp3',
          //           child: Text('Star Wars'),
          //         ),
          //         DropdownMenuItem<String>(
          //           value: 'assets/alarm.mp3',
          //           child: Text('alarm'),
          //         ),
          //       ],
          //       onChanged: (value) => setState(() => assetAudio = value!),
          //     ),
          //   ],
          // ),
          if (!creating)
            TextButton(
              onPressed: deleteAlarm,
              child: Text(
                '알람 삭제',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}

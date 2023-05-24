import 'package:app/search/searchHistory.dart';
import 'package:flutter/material.dart';
import 'package:app/ocr/OCR.dart';
import 'package:app/search/search.dart';
import 'package:app/qr/qr.dart';
import 'package:app/settings/settings_main.dart';
import 'package:app/alarms/alarm_main.dart';
import 'package:alarm/alarm.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:app/audioutill/audioUtil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // AudioUtil.setaudio();
  await Alarm.init(showDebugLogs: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'button',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyButton(),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '약리미',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.5,
          ),
          centerTitle: true,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Column(
                children: [
                  Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Expanded(
                      // QR코드 검색
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            //QR코드 검색 버튼 누르면 실행되는 기능
                            onPressed: () {
                              print('QR코드 검색 button');
                              AudioUtil.audioplay(); // 화면 전환 소리
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRcodeWidget()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/qr_code.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'QR코드 검색',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // 이미지 검색
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('이미지 검색');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/pill.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '이미지 검색',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Expanded(
                      // 약 검색
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('약 검색 button');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchApp()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/search.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '약 검색',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // 글자 인식
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('글자 인식 button');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OCRApp()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/ocr.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '글자 인식',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Expanded(
                      // 복용 알림
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AlarmWidget()),
                              );
                              print('복용 알림 button');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/alarm.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '복용 알림',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // 검색 기록
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('검색 기록 button');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchHistory()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                // padding: const EdgeInsets.all(10),
                                elevation: 0.0),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(
                                        image: AssetImage('assets/images/history.png'),
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '검색 기록',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          AudioUtil.audioplay();
                          print('환경설정 button');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsMain()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            // padding: const EdgeInsets.all(10),
                            elevation: 0.0),
                        child: const Text(
                          '환경설정',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   color:Colors.red,
                  //   width: 100,
                  //   height: 100,
                  //   padding: const EdgeInsets.all(8.0),
                  // )
                ],
              ),
            )));
  }
}

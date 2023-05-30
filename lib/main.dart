import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:app/audioutill/audioUtil.dart';

import 'package:app/qr/qr.dart';
import 'package:app/search/imageSearch.dart';
import 'package:app/ocr/OCR.dart';
import 'package:app/search/search.dart';
import 'package:app/alarms/alarm_main.dart';
import 'package:alarm/alarm.dart';
import 'package:app/search/searchHistory.dart';
import 'package:app/settings/user_info.dart';
import 'package:app/settings/allergy_info.dart';
import 'package:app/settings/help.dart';

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
        primarySwatch: ColorService.createMaterialColor(const Color(0xFFA6E3E9)),
        fontFamily: "Cafe24"
      ),
      home: const MyButton(),
    );
  }
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/medieyes.png', fit: BoxFit.contain, height: 32),
              const Text(
                '  약리미',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
                textScaleFactor: 1.5,
              )
            ]
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(color: Colors.white),
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 1.4 / 1,
                    ),
                    children: [
                      // QR코드 검색
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          //QR코드 검색 버튼 누르면 실행되는 기능
                          onPressed: () {
                            print('QR코드 검색 button');
                            AudioUtil.audioplay(); // 화면 전환 소리
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRcodeWidget()));
                            },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: const Size(130, 130),
                              elevation: 0.0),
                          child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Image(image: AssetImage('assets/images/qr_code.png'), width: 40.0),
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
                                    )
                                  )
                                ]
                              )
                          )
                        )
                      ),
                      // 이미지 검색
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('이미지 검색');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IMSAPP()));
                              },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/pill.png'), width: 40.0)),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '이미지 검색',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                      // 글자 인식
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('글자 인식 button');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OCRApp()));
                              },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/ocr.png'), width: 40.0),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '글자 인식',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                      // 약 검색
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('약 검색 button');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchApp()));
                              },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/search.png'), width: 40.0),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '약 검색',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                      // 복용 알림
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AlarmWidget()));
                              print('복용 알람 button');
                              },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 203, 241, 245),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/alarm.png'), width: 40.0),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '복용 알람',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                      // 검색 기록
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('검색 기록 button');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchHistory()));
                              },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 203, 241, 245),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/history.png'), width: 40.0)),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '검색 기록',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                      // 기본정보
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          //QR코드 검색 버튼 누르면 실행되는 기능
                          onPressed: () {
                            print('개인 기본정보 btn 눌림');
                            AudioUtil.audioplay(); // 화면 전환 소리
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const UserInfo()));
                            },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 203, 241, 245),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              maximumSize: const Size(130, 130),
                              elevation: 0.0),
                          child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Image(image: AssetImage('assets/images/user.png'), width: 40.0,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      '기본정보',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textScaleFactor: 1.5,
                                    )
                                  )
                                ]
                              )
                          )
                        )
                      ),
                      // 알러지 정보
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              AudioUtil.audioplay();
                              print('질병 및 알러지 정보 btn 눌림');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AllergyInfo(title: '')));
                              },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 203, 241, 245),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                maximumSize: const Size(130, 130),
                                elevation: 0.0),
                            child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image(image: AssetImage('assets/images/allergy.png'), width: 40.0)
                                    ),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '질병 및 알러지',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.5,
                                      )
                                    )
                                  ]
                                )
                            )
                        )
                      ),
                    ],
                  ),
                  // 도움말
                )
            )
        ),
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
                height: 56.0,
                child: ElevatedButton(
                    onPressed: () {
                      print('도움말 button');
                      AudioUtil.audioplay();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HelpWidget()));
                      },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/help.png', fit: BoxFit.contain, height: 28),
                        const Text(
                            ' 도움말',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.5
                        )
                      ],
                    )
                )
            )
        )
    );
  }
}

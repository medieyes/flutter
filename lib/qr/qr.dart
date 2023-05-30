import 'package:flutter/material.dart';
import 'package:app/audioutill/audioUtil.dart';
import 'package:url_launcher/url_launcher.dart'; // 패키지

import 'package:app/main.dart';
import 'package:app/qr/qrcamera.dart';


class QRcodeWidget extends StatefulWidget {
  const QRcodeWidget({Key? key}) : super(key: key);

  @override
  State<QRcodeWidget> createState() => _QRcodeWidgetState();
}

class _QRcodeWidgetState extends State<QRcodeWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  String name = "약 이름";
  String howeat = "복용법";
  String effect = "효능";
  String becareful = "주의사항";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' QR코드 검색',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ), textScaleFactor: 1.2,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AudioUtil.audioplay();
            Navigator.pop(context);
            },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AudioUtil.audioplay();
              Navigator.popUntil(context, (route) => false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()));
              },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
          physics: const FixedExtentScrollPhysics(),
          // physics: NeverScrollableScrollPhysics(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                      children: [
                        //약 이름
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(height: 1.4),
                              textScaleFactor: 1.5),
                        ),
                        // 복용법
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 242, 204),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(width: 1.4, color: Colors.grey)),
                              padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                              width: MediaQuery.of(context).size.width * 0.90, // 화면의 90% 크기
                              child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: Text('복용법',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textScaleFactor: 1.5)),
                                    Text(
                                        howeat.trim(),
                                        style: const TextStyle(height: 1.4),
                                        textScaleFactor: 1.2)
                                  ]
                              )
                          ),
                        ),
                        //효능
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 242, 204),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(width: 1.4, color: Colors.grey)),
                              padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                              width: MediaQuery.of(context).size.width * 0.90, // 화면의 90% 크기
                              child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: Text('효능',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textScaleFactor: 1.5)),
                                    Text(
                                        effect.trim(),
                                        style: const TextStyle(height: 1.4),
                                        textScaleFactor: 1.2),
                                  ]
                              )
                          ),
                        ),
                        //주의사항
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 242, 204),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(width: 1.4, color: Colors.grey)),
                              padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                              width: MediaQuery.of(context).size.width * 0.90, // 화면의 90% 크기
                              child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: Text('주의사항',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textScaleFactor: 1.5)),
                                    Text(
                                        becareful.trim(),
                                        style: const TextStyle(height: 1.4),
                                        textScaleFactor: 1.2)
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              )
          )
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 56.0,
            child: ElevatedButton(
              onPressed: () {
                print('카메라 사용하기 button');
                AudioUtil.audioplay();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRcameraWidget())).then((value) {
                        String receive = value;
                        print('전달받은 값 : $receive');
                        List<String> data = receive.split('/');
                        if (data[0] == "medieye:") {
                          setState(() {
                            name = data[1];
                            howeat = data[2];
                            effect = data[3];
                            becareful = data[4];
                          });
                        } else if (data[0] == "http:" ||
                            data[0] == "https:") {
                          Uri _url = Uri.parse(receive);
                          _launchUrl(_url);
                        } else {}
                      });
                },
              child: const Text(
                  '카메라 사용하기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
              )
            )
          )
      )
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

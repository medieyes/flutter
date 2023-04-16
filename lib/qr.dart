import 'package:flutter/material.dart';
import 'package:app/qrcamera.dart';

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
          title: Text(
            'QR코드 검색',
            style: new TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print('카메라 사용하기 button');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QRcameraWidget()),
                            ).then((value) {
                              String receive = value;
                              print('전달받은 값 : $receive');

                              List<String> data = receive.split('//');
                              if (data[0] == "medieyes") {
                                setState(() {
                                  name = data[1];
                                  howeat = data[2];
                                  effect = data[3];
                                  becareful = data[4];
                                });
                              } else if (data[0] == "http:" ||
                                  data[0] == "https:") {
                              } else {}
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // padding: const EdgeInsets.all(10),
                              elevation: 0.0),
                          child: Text(
                            '카메라 사용하기',
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      //약 이름
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 242, 227, 219)),
                          child: Center(
                            child: Text(
                              name, // 약 이름
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    // 복용법
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(243, 232, 255, 1)),
                            child: Center(
                              child: Text(
                                howeat, // 복용법
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ))),
                  ),
                  Expanded(
                      //효능
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(220, 250, 210, 1)),
                          child: Center(
                            child: Text(
                              effect, // 복용법
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      //주의사항
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(230, 230, 230, 1)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                becareful, //주의사항
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }
}

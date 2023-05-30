import 'package:flutter/material.dart';
import 'package:app/audioutill/audioUtil.dart';

import 'package:app/main.dart';


class HelpWidget extends StatefulWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  State<HelpWidget> createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '도움말',
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    children: [
                      // QR코드 검색
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
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Image(image: AssetImage('assets/images/qr_code.png'), width: 32),
                                              Text(' QR코드 검색',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                  textScaleFactor: 1.5)
                                            ],
                                          )
                                      ),
                                      const Text(
                                          "약국에서 받은 약리미 QR코드를 통해 처방받은 약의 정보를 확인할 수 있습니다.\n\n"
                                              "하단의 카메라 사용하기 버튼을 통해 QR을 인식하는 화면으로 넘어가고 핸드폰 카메라에서 한뼘정도 떨어진 거리에 QR을 위치시키면 소리가 나면서 QR이 인식되어 정보가 화면에 나타납니다.\n\n"
                                              "약국에서 받은 약리미 QR이 아닌 다른 QR코드의 경우에도 인식 가능합니다.",
                                          style: TextStyle(height: 1.4),
                                          textScaleFactor: 1.2
                                      )
                                    ]
                                )
                            ),
                          ),
                      // 이미지 검색
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
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Image(image: AssetImage('assets/images/pill.png'), width: 32),
                                              Text(' 이미지 검색',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                  textScaleFactor: 1.5)
                                            ],
                                          )
                                      ),
                                      const Text(
                                          "포장지가 없는 상태의 알약에 대해서 사진을 통해 검색을 할 수 있습니다.\n\n"
                                              "사진을 찍는 방법은 다음과 같습니다.\n"
                                              "1. 알약을 손바닥 위에 올려두고 촬영\n"
                                              "2. 검정색을 바탕으로 알약을 올려두고 촬영\n"
                                              "\n사진 촬영 후, 조금 기다리면 알약에 대해 의약품 정보 페이지로 넘어가게 됩니다.\n\n"
                                              "이렇게 검색한 의약품 정보는 검색 기록에서 다시 볼 수 있습니다.\n"
                                              "촬영한 알약의 정보를 알 수 없다면 오류 메세지를 반환합니다.",
                                          style: TextStyle(height: 1.4),
                                          textScaleFactor: 1.2
                                      )
                                    ]
                                )
                            ),
                          ),
                      // 글자 인식
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/ocr.png'), width: 32),
                                          Text(' 글자 인식',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "글자 인식 기능은 카메라를 통해 의약품 상자, 약 봉지 등에 있는 글자를 인식할 수 있습니다.\n\n"
                                          "해당 기능을 통해 약 봉지의 시간대를 구분할 수 있고, 의약품의 이름과 상세 정보를 알 수 있습니다.\n\n"
                                          "글자 인식 기능은 '카메라 사용하기' 버튼을 터치하여 사진을 찍은 후 '확인' 버튼을 터치하여 사용할 수 있습니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                      // 약 검색
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/search.png'), width: 32),
                                          Text(' 약 검색',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "약 검색은 의약품의 정보를 검색할 수 있는 기능입니다.\n\n"
                                          "약 검색 기능 사용전에 임신여부와 알러지정보를 설정하면 보다 안전한 의약품 복용을 도와드립니다.\n\n"
                                          "검색 창에 약 이름을 입력하고, 원하는 의약품을 터치하면 상세 정보 페이지로 넘어갈 수 있습니다.\n\n"
                                          "열람한 의약품 정보는 검색 기록에서 재검색할 수 있습니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                      // 복용 알림
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/alarm.png'), width: 32),
                                          Text(' 복용 알람',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "시간을 설정하여 매일 같은 시간에 알람이 울리는 기능입니다.\n\n"
                                          "하단의 알람 설정 버튼을 통해 시간 설정과 반복 여부 등을 설정할 수 있습니다.\n\n"
                                          "설정된 알람을 다시 눌러 알람 시간을 변경하거나 삭제할 수 있습니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                      // 검색 기록
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/history.png'), width: 32),
                                          Text(' 검색 기록',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "약 검색 기능에서 상세 정보를 열람했던 의약품의 기록이 저장됩니다.\n\n"
                                          "의약품의 이름을 터치하면 해당 의약품의 상세 정보를 재검색할 수 있고,\n"
                                          "의약품 이름 우측에 존재하는 삭제 버튼을 터치하면 검색 기록을 삭제할 수 있습니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                      // 기본정보
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/user.png'), width: 32),
                                          Text(' 기본정보',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "시각장애인 여부, 성별, 생년, 임신여부를 저장합니다.\n\n"
                                          "임신여부를 통해 의약품 검색 시, 의약품의 주의사항에 임산부와 관련된 글이 존재한다면, 경고창으로 안내합니다.\n\n"
                                          "저장한 정보는 얼마든지 수정이 가능합니다. 별도의 저장 버튼 없이 수정한 즉시 정보는 저장됩니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                      // 질병 및 알러지
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
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Image(image: AssetImage('assets/images/allergy.png'), width: 32),
                                          Text(' 질병 및 알러지',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textScaleFactor: 1.5)
                                        ],
                                      )
                                  ),
                                  const Text(
                                      "총 20가지의 질병과 알러지 정보에 대해서 저장할 수 있습니다.\n\n"
                                          "저장한 정보는 얼마든지 수정이 가능합니다. 별도의 저장 버튼 없이 수정한 즉시 정보는 저장됩니다.\n\n"
                                          "저장한 질병 및 알러지가 검색한 의약품의 주의사항에 존재한다면,\n"
                                          "경고창을 통해 어떤 질병 및 알러지와 관련되어 있는지 안내합니다.",
                                      style: TextStyle(height: 1.4),
                                      textScaleFactor: 1.2
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}

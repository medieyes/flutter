import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/audioutill/audioUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/main.dart';
import 'package:app/search/searchPage.dart';

void main() => runApp(IMSAPP());

class IMSAPP extends StatefulWidget {
  const IMSAPP({Key? key}) : super(key: key);

  @override
  IMSAPPState createState() => IMSAPPState();
}

class IMSAPPState extends State<IMSAPP> {
  @override
  Widget build(BuildContext context) {
    return ImageSelectionScreen();
  }
}

class ImageSelectionScreen extends StatefulWidget {
  @override
  ImageSelectionScreenState createState() => ImageSelectionScreenState();
}

// 사진 촬영
class ImageSelectionScreenState extends State<ImageSelectionScreen> {
  final _prefsPregnancyKey = 'selectedPregnancy';
  late SharedPreferences _prefsPregnancy;
  int? _selectedPregnancy;

  Map<String, dynamic> allergies = {
    // 알러지 정보
    '해산물': false,
    '견과류': false,
    '곡류': false,
    '천식': false,
    '아토피': false,
    '비염': false,
    '혈압': false,
    '신부전증': false,
    '과민증': false,
    '당뇨': false,
    '암': false,
    '편두통': false,
    '간질환': false,
    '신장질환': false,
    '소화기질환': false,
    '호흡질환': false,
    '정신질환': false,
    '근육질환': false,
    '심혈관질환': false,
    '뇌혈관질환': false,
  };

  void loadSelectedAllergies() async {
    // 알러지 정보 및 임신 여부 함수
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _prefsPregnancy = await SharedPreferences.getInstance();

    setState(() {
      _selectedPregnancy = _prefsPregnancy.getInt(_prefsPregnancyKey) ?? 0;
    });
    await _prefsPregnancy.setInt(_prefsPregnancyKey, _selectedPregnancy ?? 0);

    setState(() {
      allergies = Map<String, dynamic>.from(prefs.getString('allergies') != null
          ? json.decode(prefs.getString('allergies')!)
          : {
              '해산물': false,
              '견과류': false,
              '곡류': false,
              '천식': false,
              '아토피': false,
              '비염': false,
              '혈압': false,
              '신부전증': false,
              '과민증': false,
              '당뇨': false,
              '암': false,
              '편두통': false,
              '간질환': false,
              '신장질환': false,
              '소화기질환': false,
              '호흡질환': false,
              '정신질환': false,
              '근육질환': false,
              '심혈관질환': false,
              '뇌혈관질환': false,
            });
    });
    // print(_selectedPregnancy); // 임신 여부 테스트용
    // print(allergies); // 테스트용 프린트
  }

  String? trueAllergies(Map<String, dynamic> allergies, item) {
    // print(item['atpnQesitm']); // 테스트용 프린트
    // 알러지 및 임신 여부 비교 및 경고
    String? result;
    allergies.forEach((key, value) {
      // 알러지 비교 후 result 에 해당하는 알러지 단어 누적
      if (value == true) {
        if (item['atpnQesitm'] != null && item['atpnQesitm'].contains(key) ||
            item['atpnWarnQesitm'] != null &&
                item['atpnWarnQesitm'].contains(key)) {
          result = result != null ? result! + ', ' + key + ' ' : key + ' ';
        }
      }
    });
    if (_selectedPregnancy == 1) {
      // 임산부 일 때, 임산부 임부 임신 3가지 단어 비교
      if ((item['atpnQesitm'] != null && // 주의사항
              (item['atpnQesitm'].contains("임산부") ||
                  item['atpnQesitm'].contains("임부") ||
                  item['atpnQesitm'].contains("임신") ||
                  item['atpnQesitm'].contains("수유부"))) ||
          (item['atpnWarnQesitm'] != null && // 주의사항경고
              (item['atpnWarnQesitm'].contains("임산부") ||
                  item['atpnQesitm'].contains("임부") ||
                  item['atpnQesitm'].contains("임신") ||
                  item['atpnQesitm'].contains("수유부")))) {
        result = result != null ? result! + ', ' + "임산부" + ' ' : "임산부" + ' ';
      }
    }
    return result;
  }

  Future<void> getImage() async {
    loadSelectedAllergies();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      var url = Uri.parse('http://3.34.125.219/file/');
      var imagePath = pickedFile.path;

      // 파일 열기
      var file = File(imagePath);

      // 파일 데이터 읽기
      var fileBytes = await file.readAsBytes();

      // 요청 보내기
      var request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: 'image.jpg',
          contentType: MediaType.parse('image/jpeg'),
        ));

      // 응답 받기
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // 응답 확인
      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        var classification = data['class'];
        fetchData(classification);
        print('Class: $classification');
      } else {
        print('요청이 실패했습니다.');
      }
    }
  }

  Future<void> fetchData(String searchRecord) async {
    loadSelectedAllergies();
    var url = Uri.parse(
        'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList'); // API 서버의 URL 주소
    var params = {
      'serviceKey':
          'euf1Zh/Ry00s3mzLoKv49YQE44utBM56c8gUYT9LdUAnChnbXAtVJihhQYbWVXxkPlC2yJJlgn8iQT1aEs+jOg==', // API 키
      'itemName': searchRecord, // 사용자가 선택한 검색 기록을 itemName으로 설정
      'type': 'json' // JSON 타입
    };

    var response = await http.get(url.replace(queryParameters: params));
    final json = jsonDecode(response.body);
    String? result = trueAllergies(allergies, json['body']['items'][0]);
    if (result != null && result.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "경고",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.5,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("다음과 같은 알러지 유발 물질이 포함되어 있습니다.\n",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.1),
                Text('" ' + result.trim() + ' "',
                    style: const TextStyle(color: Colors.red),
                    textScaleFactor: 1.5),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("확인",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 113, 201, 206),
                    )),
                onPressed: () {
                  Navigator.pop(context); // 경고창 닫기
                  AudioUtil.audioplay(); // 화면 전환 소리
                  Navigator.push(
                      // 의약품 상세페이지로 이동
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchPage(item: json['body']['items'][0])));
                },
              ),
            ],
          );
        },
      );
    } else {
      AudioUtil.audioplay(); // 화면 전환 소리
      Navigator.push(
          // 의약품 상세페이지로 이동
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SearchPage(item: json['body']['items'][0])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이미지 검색',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold),
          textScaleFactor: 1.2,
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
              AudioUtil.audioplay(); // 화면 전환 소리
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
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       AudioUtil.audioplay(); // 화면 전환 소리
      //       getImage();
      //     },
      //     child: const Text(
      //       '사진 찍기',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
      body: const Padding(
          padding: EdgeInsets.all(25),
          child: Center(
              child: Text(
                  "약을 손바닥 위나 검정색을 배경으로 촬영해주세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.4),
                  textScaleFactor: 1.3
              )
          )
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
              height: 56.0,
              child: ElevatedButton(
                onPressed: () {
                  AudioUtil.audioplay(); // 화면 전환 소리
                  getImage();
                },
                child: const Text(
                    '카메라 사용하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.5
                ),
              )
          )
      ),
    );
  }
}

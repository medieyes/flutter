import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/audioutill/audioUtil.dart';

import 'package:app/main.dart';

void main() => runApp(OCRApp());

class OCRApp extends StatelessWidget {
  const OCRApp({Key? key}) : super(key: key);
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
  String result = ''; // OCR 결과를 저장할 변수
  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // API 엔드포인트 URL
      String apiUrl =
          'https://c7ulcdtg3k.apigw.ntruss.com/custom/v1/21393/a1fc963e0e2561d86135dcdca7004ff703dab7708c96d070ebd52a28ec853602/general';

      // API 키
      String apiKey = 'WnlMQ0x1SnlCd0JCbmlhWVBOWWVtUFdTb1lFZXNaRWM=';

      // 이미지 파일 경로
      String imageFilePath = pickedFile.path;

      // API 요청 헤더
      Map<String, String> headers = {
        'X-OCR-SECRET': apiKey,
        'Content-Type': 'application/json'
      };

      // API 요청 바디
      Map<String, dynamic> requestBody = {
        'images': [
          {'format': 'jpg', 'name': 'demo'}
        ],
        'requestId': Uuid().v4(),
        'version': 'V2',
        'timestamp': DateTime.now().millisecondsSinceEpoch
      };

      // 이미지 파일 바이너리 읽기
      File imageFile = File(imageFilePath);
      List<int> imageBytes = await imageFile.readAsBytes(); // 이진데이터로 변환

      // 이미지 바이너리 인코딩 및 API 요청 바디에 추가
      String base64Image = base64Encode(imageBytes); // 이진데이터를 base64로 인코딩
      requestBody['images'][0]['data'] =
          base64Image; // data를 base64로 인코딩한 값으로 저장

      // API 요청
      http.Response response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonEncode(requestBody));

      // API 응답 처리
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> fields = responseBody['images'][0]['fields']; // 필드이름 저장
        result = fields
            .map((field) => field['inferText']) // 필드이름이 inferText인 것만 추출
            .join(' '); // infertext 합치기
        print(responseBody); // 리스폰스 출력(원래 전체값)
        print(result); // intertext만 출력(추출한 값)
        setState(() {
          result = result; // result 최신화
        });
      } else {
        print('API request failed with status code ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글자 인식',
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
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  result,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.4
                    ),
                    textScaleFactor: 1.3
                )
            ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ), textScaleFactor: 1.5
                ),
              )
          )
      ),
    );
  }
}
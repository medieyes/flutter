import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app/main.dart';
import 'searchPage.dart';
import 'package:app/settings/allergy_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(SearchApp());

class SearchApp extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchApp> {
  final TextEditingController meName = TextEditingController();
  List<dynamic> itemList = []; // 의약품 리스트

  Map<String, dynamic> allergies = {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    print(allergies);
  }

  Future<void> getData() async {
    // 검색 버튼 눌렀을때
    loadSelectedAllergies();
    var url = Uri.parse(
        'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList'); // url주소
    var params = {
      'serviceKey':
          'euf1Zh/Ry00s3mzLoKv49YQE44utBM56c8gUYT9LdUAnChnbXAtVJihhQYbWVXxkPlC2yJJlgn8iQT1aEs+jOg==', // api키
      'itemName': meName.text, // 사용자가 입력한 값
      'type': 'json' // json 타입
    };

    var response = await http.get(url.replace(queryParameters: params));
    print(response.body); // 테스트용 print

    final json = jsonDecode(response.body);
    setState(() {
      itemList = json['body']['items']; // 리스트에 저장
    });
  }

  List<Widget> buildItemListButtons() {
    return itemList
        .map((item) => ElevatedButton(
            // 의약품 리스트대로 텍스트 버튼 생성
            onPressed: () {
              // 의약품 터치했을 때
              // 알러지의 true 값과 의약품의 주의사항경고 비교
              //if (item['atpnWarnQesitm'] || item['atpnQesitm'])
              // 참이면 showDialog경고창 띄우기
              // else는 그냥 상세페이지 이동
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("경고"),
                    content: Text("의약품 복용에 주의해주세요."),
                    // 어떤 거랑 겹치는지 Text 수정 예정
                    actions: [
                      TextButton(
                        child: Text("확인"),
                        onPressed: () {
                          Navigator.pop(context); // 경고창 닫기
                          Navigator.push(
                              // 의약품 상세페이지로 이동
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPage(item: item)));
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.85, // 화면 크기의 85%
                child: Text(
                  item['itemName'], // 의약품 이름으로 Text 설정
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            )))
        .expand((button) => [button, SizedBox(height: 20)]) // 버튼 간격
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '약 검색',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
      body: Column(
        children: [
          TextFormField(
            // 검색필드
            controller: meName,
            decoration: const InputDecoration(
              labelText: '약 이름을 작성해주세요',
            ),
          ),
          ElevatedButton(
            // 검색 버튼
            onPressed: getData,
            child: const Text(
              '검색',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            // 검색 버튼아래에 빈공간 만들기
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItemListButtons(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

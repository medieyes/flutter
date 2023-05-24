import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'searchPage.dart';
import 'package:app/main.dart';

class SearchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();

  static Future<void> saveSearchRecord(String itemName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchRecords = prefs.getStringList('searchRecords');

    if (searchRecords == null) {
      searchRecords = [];
    }

    searchRecords.add(itemName);
    await prefs.setStringList('searchRecords', searchRecords);
  }
}

class _SearchHistoryState extends State<SearchHistory> {
  // 임신 관련 변수
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

  Future<List<String>> _loadSearchRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchRecords = prefs.getStringList('searchRecords');
    return searchRecords ?? [];
  }

  static Future<void> saveSearchRecord(String itemName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchRecords = prefs.getStringList('searchRecords');

    if (searchRecords == null) {
      searchRecords = [];
    }

    searchRecords.add(itemName);
    await prefs.setStringList('searchRecords', searchRecords);
  }

  Future<void> _deleteSearchRecord(String searchRecord) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchRecords = prefs.getStringList('searchRecords');

    if (searchRecords != null) {
      searchRecords.remove(searchRecord);
      await prefs.setStringList('searchRecords', searchRecords);
      setState(() {});
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
                Text('{ ' + result + '}',
                    style: const TextStyle(color: Colors.red),
                    textScaleFactor: 1.5),
              ],
            ),
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
                              SearchPage(item: json['body']['items'][0])));
                },
              ),
            ],
          );
        },
      );
    } else {
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
    return MaterialApp(
      title: 'Search History',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '검색 기록',
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
        body: FutureBuilder<List<String>>(
          future: _loadSearchRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final searchRecords = snapshot.data!;
              return ListView.builder(
                itemCount: searchRecords.length,
                itemBuilder: (context, index) {
                  final searchRecord = searchRecords[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        searchRecord,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteSearchRecord(searchRecord);
                        },
                      ),
                      onTap: () {
                        fetchData(searchRecord);
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No search records found.'));
            }
          },
        ),
      ),
    );
  }
}

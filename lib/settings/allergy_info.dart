import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/main.dart';

void main() => runApp(const AllergyInfo(title: '',));

class AllergyInfo extends StatefulWidget {
  const AllergyInfo({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<AllergyInfo> createState() => _AllergyInfoState();
}

class _AllergyInfoState extends State<AllergyInfo> {
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

  List<String> _selectedAllergies = [];

  _saveAllergies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('allergies', json.encode(allergies));

    for (String key in allergies.keys){
      if (allergies[key] == true){
        if (!_selectedAllergies.contains(key)){
          _selectedAllergies.add(key);
        }
      } else {
          if (_selectedAllergies.contains(key)){
            _selectedAllergies.remove(key);
          }
      }
    }
    prefs.setStringList('_selectedAllergies', _selectedAllergies);
    print(_selectedAllergies);
  }

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

  @override
  void initState() {
    super.initState();
    loadSelectedAllergies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '질병 및 알러지 정보',
            style: TextStyle(
              fontSize: 25.0,
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
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '알러지 추가',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left
                              )
                          )
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 35.0,
                            maxHeight: 520.0,
                          ),
                        child: Scaffold(
                          body: ListView(
                            padding: const EdgeInsets.all(8.0),
                            children: allergies.keys.map((String key) {
                              return CheckboxListTile(
                                title: Text(key),
                                value: allergies[key],
                                onChanged: (value) {
                                  setState(() {
                                    allergies[key] = value!;
                                    _saveAllergies();
                                  });
                                },
                              );
                            }).toList(),
                          ),
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
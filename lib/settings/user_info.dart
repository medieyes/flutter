import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/main.dart';

void main() => runApp(const UserInfo());

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _prefsVisualKey = 'selectedVisualImpairment';
  final _prefsGenderKey = 'selectedGender';
  final _prefsYearKey = 'selectedYear';
  final _prefsPregnancyKey = 'selectedPregnancy';
  late SharedPreferences _prefsVisual;
  late SharedPreferences _prefsGender;
  late SharedPreferences _prefsYear;
  late SharedPreferences _prefsPregnancy;

  int? _selectedVisualImpairment;
  int? _selectedGender;
  int _selectedYear = 0;
  int? _selectedPregnancy;
  final Color? _selectedBackColor = Colors.orangeAccent[100];

  List<String> yearsList = List.generate(94, (index) => "${2023 - index}년");
  static const double _kItemExtent = 32.0;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefsVisual = await SharedPreferences.getInstance();
    _prefsGender = await SharedPreferences.getInstance();
    _prefsYear = await SharedPreferences.getInstance();
    _prefsPregnancy = await SharedPreferences.getInstance();
    _loadSelectedVisualImpairment();
    _loadSelectedGender();
    _loadSelectedYear();
    _loadSelectedPregnancy();
  }

  void _loadSelectedVisualImpairment() {
    setState(() {
      _selectedVisualImpairment = _prefsVisual.getInt(_prefsVisualKey) ?? 0;
    });
  }
  void _saveSelectedVisualImpairment(dynamic value) async {
    setState(() {
      _selectedVisualImpairment = value as int?;
    });
    await _prefsVisual.setInt(_prefsVisualKey, _selectedVisualImpairment ?? 0);
  }

  void _loadSelectedGender() {
    setState(() {
      _selectedGender = _prefsGender.getInt(_prefsGenderKey) ?? 0;
    });
  }
  void _saveSelectedGender(dynamic value) async {
    setState(() {
      _selectedGender = value as int?;
    });
    await _prefsGender.setInt(_prefsGenderKey, _selectedGender ?? 0);
  }

  void _loadSelectedPregnancy() {
    setState(() {
      _selectedPregnancy = _prefsPregnancy.getInt(_prefsPregnancyKey) ?? 0;
    });
  }
  void _saveSelectedPregnancy(dynamic value) async {
    setState(() {
      _selectedPregnancy = value as int?;
    });
    await _prefsPregnancy.setInt(_prefsPregnancyKey, _selectedPregnancy ?? 0);
  }

  void _loadSelectedYear() async {
    setState(() {
      _selectedYear = _prefsYear.getInt(_prefsYearKey) ?? 0;
    });
  }
  void _saveSelectedYear(dynamic value) async {
    setState(() {
      _selectedYear = (value as int?)!;
    });
    await _prefsYear.setInt(_prefsYearKey, _selectedYear ?? 0);
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '개인 기본정보',
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
                            '시각장애인 여부',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedVisualImpairment(1);
                              },
                              child: Container(
                                color: _selectedVisualImpairment == 1
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 1,
                                      groupValue: _selectedVisualImpairment,
                                      onChanged: _saveSelectedVisualImpairment,
                                    ),
                                    const Text(
                                      '예',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedVisualImpairment(0);
                              },
                              child: Container(
                                color: _selectedVisualImpairment == 0
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 0,
                                      groupValue: _selectedVisualImpairment,
                                      onChanged: _saveSelectedVisualImpairment,
                                    ),
                                    const Text(
                                      '아니오',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '성별',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left
                              )
                          )
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedGender(1);
                              },
                              child: Container(
                                color: _selectedGender == 1
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 1,
                                      groupValue: _selectedGender,
                                      onChanged: _saveSelectedGender,
                                    ),
                                    const Text(
                                      '남자',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedGender(0);
                              },
                              child: Container(
                                color: _selectedGender == 0
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 0,
                                      groupValue: _selectedGender,
                                      onChanged: _saveSelectedGender,
                                    ),
                                    const Text(
                                      '여자',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '생년',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left
                              )
                          )
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        // Display a CupertinoPicker with list of fruits.
                        onPressed: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                _selectedYear = selectedItem;
                              });
                              _saveSelectedYear(selectedItem);
                            },
                            // Set the default selected item to _selectedYear.
                            scrollController: FixedExtentScrollController(initialItem: _selectedYear),
                            children: List<Widget>.generate(yearsList.length, (int index) {
                              return Center(
                                child: Text(
                                  yearsList[index],
                                ),
                              );
                            }),
                          ),
                        ),
                        // This displays the selected fruit name.
                        child: Text(
                          yearsList[_selectedYear],
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  '임신여부',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left
                              )
                          )
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedPregnancy(1);
                              },
                              child: Container(
                                color: _selectedPregnancy == 1
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 1,
                                      groupValue: _selectedPregnancy,
                                      onChanged: _saveSelectedPregnancy,
                                    ),
                                    const Text(
                                      '예',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _saveSelectedPregnancy(0);
                              },
                              child: Container(
                                color: _selectedPregnancy == 0
                                    ? _selectedBackColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Radio<dynamic>(
                                      value: 0,
                                      groupValue: _selectedPregnancy,
                                      onChanged: _saveSelectedPregnancy,
                                    ),
                                    const Text(
                                      '아니오',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}
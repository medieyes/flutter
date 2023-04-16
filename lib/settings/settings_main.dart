import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:app/settings/user_info.dart';
import 'package:app/settings/allergy_info.dart';
// import 'package:app/settings/app_setting.dart';

void main() => runApp(const SettingsMain());

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '환경설정',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => false);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
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
          padding: const EdgeInsets.fromLTRB(10,20,10,20),
          child:Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              children: [
                Expanded(
                  // 개인 기본정보
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('개인 기본정보 btn 눌림');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfo()
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // padding: const EdgeInsets.all(10),
                          elevation: 0.0
                        ),
                        child: const Text(
                          '개인 기본정보',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // 질병 및 알러지 정보
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('질병 및 알러지 정보 btn 눌림');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllergyInfo(title: '',)
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent[100], // 텍스트 버튼과 다르게 배경색 변경
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // padding: const EdgeInsets.all(10),
                          elevation: 0.0
                        ),
                        child: const Text(
                          '질병 및 알러지 정보',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   // 앱 환경설정
                //   flex: 1,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: SizedBox(
                //       width: double.infinity,
                //       child: ElevatedButton(
                //         onPressed: () {
                //           print('앱 환경설정 btn 눌림');
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const MyStatefulWidget()
                //             ),
                //           );
                //         },
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           // padding: const EdgeInsets.all(10),
                //           elevation: 0.0
                //         ),
                //         child: const Text(
                //           '앱 환경설정',
                //           style: TextStyle(
                //             fontSize: 30.0,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  // 음성 도움말
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('음성 도움말 btn 눌림');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent, // 텍스트 버튼과 다르게 배경색 변경
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // padding: const EdgeInsets.all(10),
                          elevation: 0.0
                        ),
                        child: const Text(
                          '음성 도움말',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
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

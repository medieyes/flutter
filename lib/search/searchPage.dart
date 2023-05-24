import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final dynamic item;

  const SearchPage({Key? key, required this.item}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('의약품 정보',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.5),
      ),
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 약 이름
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(widget.item['itemName'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                      textScaleFactor: 1.5),
                ),
                // 제조사
                if (widget.item['entpName'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 242, 204),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1.4, color: Colors.grey)),
                      padding: EdgeInsets.all(10), // 모든 방향으로 여백
                      width: MediaQuery.of(context).size.width *
                          0.90, // 화면의 90% 크기
                      child: Text('제조사 : ' + widget.item['entpName'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(height: 1.4),
                          textScaleFactor: 1.2),
                    ),
                  ),

                // 효능
                if (widget.item['efcyQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text('효능',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.5)),
                          Text(
                              widget.item['efcyQesitm']
                                  .replaceAll(RegExp(r'<[^>]*>'), "")
                                  .trim(),
                              style: const TextStyle(height: 1.4),
                              textScaleFactor: 1.2),
                        ])),
                  ),

                // 사용법
                if (widget.item['useMethodQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('사용법',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['useMethodQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),

                // 주의사항경고
                if (widget.item['atpnWarnQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('주의사항 경고',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['atpnWarnQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),

                // 주의사항
                if (widget.item['atpnQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('주의사항',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['atpnQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),

                // 상호작용
                if (widget.item['intrcQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('상호작용',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['intrcQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),

                // 부작용
                if (widget.item['seQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: const EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('부작용',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['seQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),

                // 보관방법
                if (widget.item['depositMethodQesitm'] != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 242, 204),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.4, color: Colors.grey)),
                        padding: EdgeInsets.all(10.0), // 모든 방향으로 여백
                        width: MediaQuery.of(context).size.width *
                            0.90, // 화면의 90% 크기
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('보관방법',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5)),
                            Text(
                                widget.item['depositMethodQesitm']
                                    .replaceAll(RegExp(r'<[^>]*>'), "")
                                    .trim(),
                                style: const TextStyle(height: 1.4),
                                textScaleFactor: 1.2),
                          ],
                        )),
                  ),
              ],
            ),
          )),
    );
  }
}

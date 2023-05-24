import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:app/audioutill/audioUtil.dart';

class QRcameraWidget extends StatefulWidget {
  const QRcameraWidget({super.key});

  @override
  State<QRcameraWidget> createState() => _QRcameraWidgetState();
}

class _QRcameraWidgetState extends State<QRcameraWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;

  String result = "QR코드가 인식되면 소리가 나면서 화면이 전환됩니다.";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //QR코드 기능
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        //태그로 잘라서 바로 넘어감
        if (scanData.code!.contains('medieye:')) {
          AudioUtil.audioplay();
          this.controller!.dispose();
          Navigator.pop(context, scanData.code);
        } else if (scanData.code!.contains('https:')) {
          AudioUtil.audioplay();
          this.controller!.dispose();
          Navigator.pop(context, scanData.code);
        } else if (scanData.code!.contains('http:')) {
          AudioUtil.audioplay();
          this.controller!.dispose();
          Navigator.pop(context, scanData.code);
        } else {
          setState(() {
            result = scanData.code!;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QR코드 카메라",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRcameraWidget extends StatefulWidget {
  const QRcameraWidget({super.key});

  @override
  State<QRcameraWidget> createState() => _QRcameraWidgetState();
}

class _QRcameraWidgetState extends State<QRcameraWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "";

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
        if (scanData.code!.contains('레세티정')) {
          this.controller!.dispose();
          Navigator.pop(context, scanData.code);
        }
      }

      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Scanner"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "QR코드를 카메라에 보여주세요",
                  style: TextStyle(fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }
}

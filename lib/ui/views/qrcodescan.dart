import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'QR Code Scanner',
//       home: QRCodeScannerScreen(),
//     );
//   }
// }

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String _scannedCode = '';
  // Variable to hold the scanned QR code value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Scanned QR Code: $_scannedCode', // Display scanned QR code value
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Start QR code scanning
              _controller?.toggleFlash();
            },
            child: Text('Toggle Flashlight'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code data
      _scannedCode =
          scanData.code ?? 'No data'; // Update the scanned QR code value
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

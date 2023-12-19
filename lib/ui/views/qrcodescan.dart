import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/models/farmacia_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import '../../models/descarte_model.dart';

class QRCodePage extends StatefulWidget {
  final DescarteModel? pendingDiscard;
  final Function updateHome;
  const QRCodePage({super.key, required this.updateHome, required this.pendingDiscard});

  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;



  Future<FarmaciaModel>? getFarmaciaById() {
    if(_result != null) {
      Future<FarmaciaModel>? farmaciaEscolhida;
      DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance
          .doc('/farmacias/${_result!.code}');
      setState(() {
        farmaciaEscolhida = documentReference
            .get()
            .then((value) => FarmaciaModel.fromJson(documentReference.id, value.data()!));
      });
     return farmaciaEscolhida;
    }
    return null;
  }



  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digitalizar QR code'),
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _controller?.toggleFlash();
            },
            icon: Icon(
              Icons.flashlight_on
            ),
          ),
        ],
      ),
      body: _result == null? Column(
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
                )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Leia um QR Code', // Display scanned QR code value
              style: TextStyle(fontSize: 18),
            ),
          ),

        ],
      ) : FutureBuilder<FarmaciaModel>(
          future: getFarmaciaById(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    color: Colors.teal,
                    child: Text(
                      'Deseja realizar o descarte em:\n ${snapshot.data!.nome}?', // Display scanned QR code value
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width/5,
                      right: MediaQuery.of(context).size.width/5,
                      top: MediaQuery.of(context).size.height/5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> update = {"farmacia": snapshot.data!.id};
                            DocumentReference documentReference = FirebaseFirestore.instance.doc('/descartes/${widget.pendingDiscard!.id}');
                            await documentReference.update(
                                update
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Descarte concluído!")));
                              widget.updateHome();
                            }

                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                          child: Text('Sim')
                        ),
                        Spacer(flex: 1,),
                        ElevatedButton(
                            onPressed: (){setState(() {
                              _result = null;
                            });},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
                            child: Text('Não')
                        ),

                      ],
                    ),
                  )
                ],
              );
            } else {
              return Text(
                'Código QR inválido', // Display scanned QR code value
                style: TextStyle(fontSize: 18),
              );
            }
          }
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

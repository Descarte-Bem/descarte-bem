import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../../models/descarte_model.dart';

final ScreenshotController screenshotController = ScreenshotController();

void _saveImage(image) async {
  // Save the captured image to the device's gallery
  // Print the result of the saving operation
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  DescarteModel? pendingDiscard;
  final qrKey = GlobalKey(debugLabel: 'QR');

  getPendingDiscard() async {
    List<DescarteModel> discardList = await FirebaseFirestore.instance
        .collection('descartes')
        .where('usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) =>
            value.docs.map(DescarteModel.fromQueryDocSnapshot).toList());
    for (var discard in discardList) {
      if (discard.farmaciaId == null) {
        setState(() {
          pendingDiscard = discard;
        });
        return;
      }
    }
    setState(() {
      pendingDiscard = null;
    });
  }

  disCard(DescarteModel descarte) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 65),
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.teal.shade200,
        ),
        child: ListView.separated(
          separatorBuilder: (_, __) {
            return Divider();
          },
          itemCount: descarte.descartes.length,
          itemBuilder: (context, index) {
            var descarteAtual = descarte.descartes[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  descarteAtual['subcategoria'] == ''
                      ? descarteAtual['categoria'][0].toUpperCase() +
                          descarteAtual['categoria'].substring(1)
                      : descarteAtual['subcategoria'][0].toUpperCase() +
                          descarteAtual['subcategoria'].substring(1),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 30),
                ),
                Text(
                  descarteAtual['subcategoria'] == ''
                      ? ''
                      : descarteAtual['categoria'][0].toUpperCase() +
                          descarteAtual['categoria'].substring(1),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 30),
                ),
                Text(
                  descarteAtual['quantidade'].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 30),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    getPendingDiscard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var hei = MediaQuery.of(context).size.height;
    screenshotController
        .captureFromWidget(
      QrImageView(
        data: '1234567890',
        version: QrVersions.auto,
        size: 50.0,
      ),
    )
        .then((capturedImage) {
      Image.memory(capturedImage);
      // Handle captured image
    });

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.restart_alt, color: Colors.grey,),
          onPressed: (){
            getPendingDiscard();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Página atualizada!")));
          },
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarte Bem"),
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 22),
        centerTitle: true,
        actions: const [CircularAvatarButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: hei * 0.18,
              width: wid * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: pendingDiscard == null
                      ? Text(
                          'Faça um novo descarte!',
                          style: TextStyle(
                              fontSize: 20, color: Colors.teal.shade900),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Você possui um descarte pendente:',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.teal.shade900),
                            ),
                            disCard(pendingDiscard!),
                          ],
                        )),
            ),
            Image.asset(
              'assets/medicine-bro.gif',
              height: hei * 0.3,
            ),

          Container(
            width: MediaQuery.of(context).size.width * 0.8,
             //height: MediaQuery.of(context).size.height * 0.070,
              decoration: const BoxDecoration(
               //color: Colors.pink,
            ),

            child: const Column(

              children: [
                  Text('A preservação do meio ambiente começa com pequenas atitudes '
                    'diárias.',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                ),
            ),
                  Text('Comece a descartar medicamentos de forma consciente agora mesmo',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ),






          pendingDiscard == null ?
            ElevatedButton(
              onPressed: () async {
                await getPendingDiscard();
                if (pendingDiscard == null) {
                  Navigator.pushNamed(context, '/descarte');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Você possui um descarte pendente")));
                }
              },
              child: const Text('Iniciar novo descarte'),
            ) :
            ElevatedButton(
              onPressed: () async {
                await getPendingDiscard();
                if (pendingDiscard == null){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Você já realizou o descarte!")));
                  }
                else {
                  Navigator.pushNamed(context, '/qrcodescan');
                }
              },
              child: const Text('Efetuar descarte'),
            ),
            TextButton(onPressed: () {Navigator.pushNamed(context, '/historico');},
                child: const Text(
                    'Veja seu histórico de descarte aqui.'
                )
            ),

          ], //children
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              size: 25,
            ),
            label: 'Infomações',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_rounded,
              size: 25,
            ),
            label: 'Mapa',
          ),
        ],
        onTap: (int index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
        selectedItemColor: Colors.black54,
      ),
    );
  }
}

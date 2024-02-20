import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/ui/views/instrucoes_page.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/descarte_model.dart';
import '../widgets/actions_bar.dart';
import '../widgets/custom_appbar.dart';
import 'descarte_page.dart';

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

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: CustomAppBar(context: context,),
      body: SingleChildScrollView(
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
                        )
              )

            ),

            /*ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InstrucoesPage()),
              );
            }, child: Text('Instrucoes')), */
            


            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: wid * 0.05),
                  child: Image.asset(
                    'assets/medicine-bro.gif',
                    height: hei * 0.2,
                  ),
                ),


                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: wid * 0.05),
                    child: Column(
                      children: [
                        Text('Jogar medicamentos no lixo comum ou no esgoto pode favorecer a resistência aos antimicrobianos, prejudicar o solo, os rios e mares, afetando todo o ecossistema.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: hei * 0.015,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text('Descarta Bem te orienta sobre o armazenamento e o descarte seguro de medicamentos.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: hei * 0.015,
                            color: Colors.black45,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: EdgeInsets.only(top: hei/50, bottom: hei/75),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DescartePage(updateHome: getPendingDiscard, pendingDiscard: pendingDiscard,))
                  );
                },
                child: pendingDiscard == null ? const Text('Iniciar novo descarte') :
                const Text('Continuar descarte'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: hei/50,
                bottom: hei/50,
                left: wid/20,
                right: wid/20),
              child: ActionsBar(updateHome: getPendingDiscard,),
            ),
          ], // Children
        ),
      ),
    );
  }
}

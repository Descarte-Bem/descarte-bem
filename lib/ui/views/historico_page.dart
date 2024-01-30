import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/descarte_model.dart';
import '../../models/farmacia_model.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {

  Future<List<DescarteModel>> getDiscards() async {
    List<DescarteModel> discardList = await FirebaseFirestore.instance
        .collection('descartes')
        .where('usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) =>
            value.docs.map(DescarteModel.fromQueryDocSnapshot).toList());
    return discardList;
  }

  disCard(DescarteModel descarte, double hei, double wid) {
    return Padding(
      padding: EdgeInsets.only(left: wid/50, right: wid/50, top: hei/100),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 65),
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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

  Future<FarmaciaModel>? getFarmaciaById(String id) {
    Future<FarmaciaModel>? farmaciaEscolhida;
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance
        .doc('/farmacias/$id');
      farmaciaEscolhida = documentReference
          .get()
          .then((value) => FarmaciaModel.fromJson(documentReference.id, value.data()!));
    return farmaciaEscolhida;
  }

  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text('Histórico de Descartes'),
      ),
      body: FutureBuilder(
        future: getDiscards(),
        builder: (context, snapshot) {
          if (!(snapshot.hasData)) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: hei/1.2,
                    child: ListView.separated(
                      separatorBuilder: (_, __) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(),
                        );
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          FutureBuilder(
                            future: getFarmaciaById(snapshot.data![index].farmaciaId!),
                            builder: (context, snapshot2) {
                              if (snapshot2.hasData) {
                                return Text(
                                  snapshot2.data!.nome,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width / 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          disCard(snapshot.data![index], hei, wid)
                        ],);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

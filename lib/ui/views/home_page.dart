import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/descarte_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DescarteModel? pendingDiscard;

  getPendingDiscard() async {
    List<DescarteModel> discardList = await FirebaseFirestore.instance.collection('descartes')
        .where('usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
            (value) => value.docs.map(
            DescarteModel.fromQueryDocSnapshot
        ).toList()
    );
    for (var discard in discardList) {
      if(discard.farmaciaId == null){
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

  disCard(DescarteModel descarte){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height/65),
        height: MediaQuery.of(context).size.height/10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.teal.shade200,
        ),
        child: ListView.separated(
          separatorBuilder: (_, __){
            return Divider();
          },
          itemCount: descarte.descartes.length,
          itemBuilder: (context, index){
            var descarteAtual = descarte.descartes[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  descarteAtual['subcategoria'] == '' ?
                  descarteAtual['categoria'][0].toUpperCase()+descarteAtual['categoria'].substring(1):
                  descarteAtual['subcategoria'][0].toUpperCase()+descarteAtual['subcategoria'].substring(1),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width/30
                  ),
                ),
                Text(
                  descarteAtual['subcategoria'] == '' ?
                  '':
                  descarteAtual['categoria'][0].toUpperCase()+descarteAtual['categoria'].substring(1),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width/30
                  ),
                ),
                Text(
                  descarteAtual['quantidade'].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width/30
                  ),
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarte Bem"),
        titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 22
        ),
        centerTitle: true,

        actions: const [
          CircularAvatarButton()
        ],
      ),



      body: Container(
        alignment: AlignmentDirectional.center,

        child:  Column(

          children: [

            Container(
              margin: const EdgeInsets.only(top:16),
              height: hei * 0.2,
              width: wid * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),

              ),
              child: const Padding(padding: EdgeInsets.all(15),

                child: Text(
                  'Bem-vindo, Nome!',
                  style: TextStyle(fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              ),
            ),


            Image.asset('assets/medicine-bro.gif', height: hei * 0.3,),



            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.050,
              decoration: const BoxDecoration(
                //color: Colors.pink,
              ),

              child: const Center(
                child: Text('A preservação do meio ambiente começa com pequenas atitudes '
                    'diárias.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.050,
              decoration: const BoxDecoration(
                //color: Colors.pink,
              ),

              child: const Center(
                child: Text('Comece a descartar medicamentos de forma consciente agora '
                    'mesmo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),


            Padding(padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {Navigator.pushNamed(context, '/descarte');},

                child: const Text('Iniciar novo descarte'),
              ),
            ),

          ], //children
        ),
      ),






      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info, size: 25,),
            label: 'Infomações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25,),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded, size: 25,),
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




                 


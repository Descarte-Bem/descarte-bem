import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/ui/views/add_descarte_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/circular_avatar_button.dart';

class DescartePage extends StatefulWidget {
  final Function updateHome;
  const DescartePage({Key? key, required this.updateHome}) : super(key: key);

  @override
  State<DescartePage> createState() => _DescartePageState();
}

class _DescartePageState extends State<DescartePage> {
  adicionaMaterial(String categoria, String subcategoria, int quantidade){
    Map<String, dynamic> descarte = {
      "categoria": categoria,
      "subcategoria": subcategoria,
      "quantidade": quantidade
    };
    setState(() {
      novoDescarte["descarte"].add(descarte);
    });
  }

  Map<String, dynamic> novoDescarte = {
    "usuario": FirebaseAuth.instance.currentUser!.uid,
    "farmacia": null,
    "descarte": []
  };

  Widget customCard(String title, String subtitle, int number, Function delete){
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height/65),
      height: MediaQuery.of(context).size.height/15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title == '' ? subtitle[0].toUpperCase()+subtitle.substring(1):
            title[0].toUpperCase()+title.substring(1),
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/20
            ),
          ),
          Text(
            title == '' ? '':
            subtitle[0].toUpperCase()+subtitle.substring(1),
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/30
            ),
          ),
          Text(
            number.toString()+' unidade(s)',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/30
            ),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                delete();
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade800,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarte Bem"),
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 22),
        centerTitle: true,
        actions: const [CircularAvatarButton()],
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              margin: const EdgeInsets.only(top: 60),
              height: 100,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.brown[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Materiais para descarte",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: novoDescarte["descarte"].length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: customCard(
                    novoDescarte["descarte"][index]["subcategoria"],
                    novoDescarte["descarte"][index]["categoria"],
                    novoDescarte["descarte"][index]["quantidade"],
                    () => novoDescarte["descarte"].remove(novoDescarte["descarte"][index])
                  ),
                );
              }
            )),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 15),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddDescartePage(
                              addDescarte: adicionaMaterial,
                            ))
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          if(novoDescarte["descarte"].isNotEmpty){
                            await FirebaseFirestore.instance
                                .collection('descartes')
                                .add(novoDescarte);
                            if(mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Descarte adicionado com sucesso")));
                              Navigator.pop(context);
                            }
                            widget.updateHome();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Adicione um novo material primeiro")));
                          }
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
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

          if (index == 0) {
            Navigator.popAndPushNamed(context, '/info');
          }
          if (index == 1) {
            Navigator.pop(context);
          }
          if (index == 2) {
            Navigator.popAndPushNamed(context, '/map');
          }
        },
        selectedItemColor: Colors.black54,

      ),
    );
  }
}

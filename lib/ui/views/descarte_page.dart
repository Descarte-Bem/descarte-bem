import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/ui/views/add_descarte_page.dart';
import 'package:decarte_bem/ui/views/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/descarte_model.dart';
import '../widgets/circular_avatar_button.dart';

class DescartePage extends StatefulWidget {
  final DescarteModel? pendingDiscard;
  final Function updateHome;
  const DescartePage({Key? key, required this.updateHome, this.pendingDiscard}) : super(key: key);

  @override
  State<DescartePage> createState() => _DescartePageState();
}

class _DescartePageState extends State<DescartePage> {
  late Map<String, dynamic> novoDescarte;
  DescarteModel? pendingDiscard;


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

  updateDescarte() async {
    widget.updateHome();
    await getPendingDiscard();

    if(novoDescarte["descarte"].isEmpty){
      await FirebaseFirestore.instance
          .collection('descartes')
          .doc(pendingDiscard!.id)
          .delete();
    }

    else{
      await FirebaseFirestore.instance
          .collection('descartes')
          .doc(pendingDiscard!.id)
          .update(novoDescarte);
    }

    widget.updateHome();

    setState(() {});
  }

  adicionaMaterial(String categoria, String subcategoria, int quantidade) async {
    widget.updateHome();

    Map<String, dynamic> descarte = {
      "categoria": categoria,
      "subcategoria": subcategoria,
      "quantidade": quantidade
    };

    if (novoDescarte["descarte"].isEmpty){
      setState(() {
        novoDescarte["descarte"].add(descarte);
      });
      await FirebaseFirestore.instance
          .collection('descartes')
          .add(novoDescarte);
    }
    else {
      setState(() {
        novoDescarte["descarte"].add(descarte);
      });
      await updateDescarte();
    }
  }


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
            onPressed: () async {
              delete();
              await updateDescarte();
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
  void initState() {
    pendingDiscard = widget.pendingDiscard;
    print(widget.pendingDiscard);
    novoDescarte = {
    "usuario": FirebaseAuth.instance.currentUser!.uid,
    "farmacia": null,
    "descarte": []
    };

    if(pendingDiscard != null){
      setState(() {
        novoDescarte["descarte"] = pendingDiscard!.descartes;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey.shade700,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarta Bem"),
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: wid/1.5,
                    height: hei/15,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDescartePage(
                            addDescarte: adicionaMaterial,
                          ))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          Flexible(
                            child: Text(
                              "Adicionar material",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: wid/30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: hei/45,),
                  SizedBox(
                    width: wid/1.5,
                    height: hei/15,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(novoDescarte["descarte"].isNotEmpty){
                          await updateDescarte();
                          widget.updateHome();
                          if(mounted){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Descarte adicionado com sucesso")));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapPage(
                                updateHome: (){
                                  widget.updateHome();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ))
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Adicione um novo material primeiro")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          Flexible(
                            child: Text(
                              "Encontrar um local de descarte",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: wid/30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

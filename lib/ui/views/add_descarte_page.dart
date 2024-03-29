import 'package:decarte_bem/ui/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDescartePage extends StatefulWidget {
  final Function addDescarte;
  const AddDescartePage({Key? key, required this.addDescarte}) : super(key: key);

  @override
  State<AddDescartePage> createState() => _AddDescartePageState();
}

class _AddDescartePageState extends State<AddDescartePage> {
  int page = 1;
  late String selectedCategory;
  late String selectedSubcategory;
  late Widget? nextWidget;

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: CustomAppBar(context: context,),
      body: SingleChildScrollView(
        child: SizedBox(
          height: pageHeight/1.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: pageHeight/25),
                child: customProgress(page),
              ),
              Expanded(
                child: page == 1 ? FutureBuilder<Widget?>(
                  future: selectCategory(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return snapshot.data!;
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  },
                ) : nextWidget!,
              ),
              Divider(),
              ElevatedButton.icon(
                onPressed: (){
                  if(page == 1){
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      page = 1;
                    });
                  }
                },
                icon: Icon(Icons.arrow_back, color: Colors.white,),
                label: Text('Voltar', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  fromQueryDocSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> qds){
    return [qds.id, qds.data()["subcategorias"]];
  }

  Widget customCard(String title, int altura){
    double pageHeight = MediaQuery.of(context).size.height;
    return Container(
      height: pageHeight/altura,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          title[0].toUpperCase()+title.substring(1),
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width/20
          ),
        ),
      ),
    );
  }

  Widget selectQuantity(int quantidadeInterna){
    incrementButton(String op){
      return IconButton.filled(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(op == "soma" ? Colors.teal: Colors.red.shade800),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
        ),
        onPressed: (){
          int novaQuantidade = quantidadeInterna;
          if (op == "soma") {
            setState(() {
              novaQuantidade++;
            });
            nextWidget = selectQuantity(novaQuantidade);
          } else if (quantidadeInterna > 0) {
            setState(() {
              novaQuantidade--;
            });
            nextWidget = selectQuantity(novaQuantidade);
          }
        },
        icon: Icon(op == "soma" ? Icons.add : Icons.remove, color: Colors.white,)
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
          child: Text(
            selectedCategory == "perfuro-cortantes" ?
            selectedCategory[0].toUpperCase()+selectedCategory.substring(1) :
            selectedSubcategory[0].toUpperCase()+selectedSubcategory.substring(1),
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100, bottom: MediaQuery.of(context).size.height/5),
          child: Text(
            'Selecione a quantidade',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
              child: incrementButton("sub"),
            ),
            Container(
              height: MediaQuery.of(context).size.width/5,
              width: MediaQuery.of(context).size.width/5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  quantidadeInterna.toString(),
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15),
              child: incrementButton("soma"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height/15),
          child: ElevatedButton(
            onPressed: () async {
              if (quantidadeInterna > 0){
                if(selectedCategory == "perfuro-cortantes"){
                  widget.addDescarte(selectedCategory, '', quantidadeInterna);
                } else {
                  widget.addDescarte(selectedCategory, selectedSubcategory, quantidadeInterna);
                }
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("A quantidade deve ser maior do que 0")));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal
            ),
            child: Text(
              'Adicionar Material',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height/40,
                color: Colors.white
              ),
            )
          ),
        )
      ],
    );
  }


  Widget selectSubcategory(List subcategories) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
          child: Text(
            selectedCategory[0].toUpperCase()+selectedCategory.substring(1),
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
          child: Text(
            'Selecione a subcategoria',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: subcategories.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  child: customCard(subcategories[index], 20),
                  onTap: (){
                    selectedSubcategory = subcategories[index];
                    nextWidget = selectQuantity(0);
                    setState(() {
                      page += 1;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );

  }

  Future<Widget?> selectCategory() async {
    List categoryList = await FirebaseFirestore.instance.collection('categorias')
        .get()
        .then(
            (value) => value.docs.map(
              fromQueryDocSnapshot
        ).toList()
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
          child: Text(
            'Selecione a categoria',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/12),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  child: customCard(categoryList[index][0], 10),
                  onTap: (){
                    if (categoryList[index][0] == "perfuro-cortantes"){
                      selectedCategory = categoryList[index][0];
                      nextWidget = selectQuantity(0);
                      setState(() {
                        page += 2;
                      });
                    } else {
                      selectedCategory = categoryList[index][0];
                      nextWidget = selectSubcategory(categoryList[index][1]);
                      setState(() {
                        page += 1;
                      });
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget customProgress(int stage){
    Widget selectedCircle(int id, int cStage){
      return Container(
        width: MediaQuery.of(context).size.width/7,
        height: MediaQuery.of(context).size.width/7,
        decoration: BoxDecoration(
          color: cStage < id ? Colors.grey.shade600 : Colors.tealAccent.shade700,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            id.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35
            ),
          ),
        ),
      );
    }

    Widget customLine(int id, int cStage){
      return Container(
        width: MediaQuery.of(context).size.width/4.5,
        height: MediaQuery.of(context).size.height/200,
        decoration: BoxDecoration(
          color: cStage > id ? Colors.tealAccent.shade700 : Colors.grey.shade600
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selectedCircle(1, stage),
        customLine(1, stage),
        selectedCircle(2, stage),
        customLine(2, stage),
        selectedCircle(3, stage),
      ],
    );
  }


}

import 'package:flutter/material.dart';

import '../widgets/circular_avatar_button.dart';

class DescartePage extends StatefulWidget {
  const DescartePage({Key? key}) : super(key: key);

  @override
  State<DescartePage> createState() => _DescartePageState();
}

class _DescartePageState extends State<DescartePage> {
  List<String> categories = [
    'Solidos',
    'Semi-Solidos',
    'Liquidos',
    'Perfuro-cortantes',
  ];
  List<String> material = [
    'capsulas',
    'drageas',
    'comprimidos',
    'supositorios',
  ];
  List<String> componente = [
    'capsulas',
    'drageas',
    'comprimidos',
    'supositorios',
  ];

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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Materiais para descarte",
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                          // Show a bottom sheet with the list of disposal materials
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(categories[index]),
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: ListView.builder(
                                                itemCount: material.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    title:
                                                        Text(material[index]),
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context); // Close
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );

                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                                    );
                                  },
                                ),
                              );
                            },
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
                        onPressed: () {},
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

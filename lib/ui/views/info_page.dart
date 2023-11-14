import 'package:flutter/material.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, size: 30,),
              color: Colors.black54,
              onPressed: () {Navigator.pushNamed(context, '/home');},
            );
          },
        ),
      ),


      body: const Center(
        child: Text('O que será exibido na página?', style: TextStyle(
          fontSize: 20,
        ),)
      ),


      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info, size: 25,)
            ,
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
            Navigator.pushNamed(context, '/info');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/home');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }

        },
        selectedItemColor: Colors.black54,

        //selectedItemColor: Colors.black54,


      ),

    );
  }
}
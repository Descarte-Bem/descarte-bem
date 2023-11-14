import 'package:decarte_bem/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

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
      appBar: CustomAppBar(),


      body: const Center(
        child: Text('',//'O que será exibido na página?',
         style: TextStyle(
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
          if (index == 1) {
            Navigator.pop(context, '/home');
          }
          if (index == 2) {
            Navigator.popAndPushNamed(context, '/map');
          }

        },
        selectedItemColor: Colors.black54,

        //selectedItemColor: Colors.black54,


      ),

    );
  }
}
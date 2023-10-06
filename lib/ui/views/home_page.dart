import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarte Bem"),
        titleTextStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 22),
        centerTitle: true,

        actions: const [
          CircularAvatarButton()
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded, size: 30,),
              color: Colors.black54,
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),


        body: Container(
          alignment: AlignmentDirectional.center,

        child:  Column(

            children: [
             Stack(
               alignment: AlignmentDirectional.topStart,
               children: [
               Container(
                 margin: const EdgeInsets.only(top:24),
                 height: 170,
                 width: 350,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(5),
                 ),
              ),

                 //Text(' ++++++++++++++++++++++++++++++++++++', textAlign: TextAlign.center,),
               ],
               ),

            Image.asset('assets/medicine-bro.gif', height: 250,),



            Container(
              width: 360,
              height: 85,


              //color: Colors.white,
              child: const Column(
                children: [


                Text(
                 'A preservação do meio ambiente começa com pequenas atitudes diárias.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    letterSpacing: 1.3,
                    ),
                  ),
                Text(
                  'Comece a descartar medicamentos de forma consciente agora mesmo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    ),
                  ),



                ],

              ),

            ),


              /*Container(
                color: Colors.blue,
                width: 350.0,
                height: 80.0,
                child: const FittedBox(
                fit: BoxFit.contain,

                  child:  Text('A preservação do meio ambiente '
                      'começa com pequenas atitudes diárias.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20, ),
                 ),
                 ),
                ),*/

            /*const Text(
              'Comece a descartar medicamentos de forma consciente agora mesmo!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black45,

              ),
            ),*/




            //Botão para outra página
            ElevatedButton(

              onPressed: () {Navigator.pushNamed(context, '/descarte');},

              child: Text('Iniciar novo descarte'),
            )

          ],
        ),

      ),
      drawer: const Drawer(
        child: SafeArea(
            child: ListTile(
              title: Text('Menu Lateral'),
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
          label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapa',
          ),
        ],
        onTap: (int index) {},
        selectedItemColor: Colors.black54,
      ),
    );
  }
}




                 


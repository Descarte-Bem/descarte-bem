import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// Itens do popMenuButton
enum MenuItem { itemOne }

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
              icon: const Icon(Icons.menu),
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
                 height: 200,
                 width: 350,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                 ),
              ),

                 //Text(' ++++++++++++++++++++++++++++++++++++', textAlign: TextAlign.center,),
               ],
               ),

            Image.asset('assets/medicine-bro.gif', height: 225,),
            const Text('A preservação do meio ambiente começa com pequenas atitudes diárias.',
              textAlign: TextAlign.center,),
            const Text('Comece a descartar medicamentos de forma consciente agora mesmo!',
              textAlign: TextAlign.center,),



            //Botão para outra página
            ElevatedButton(

              onPressed: () { },

              child: Text('Iniciar novo descarte'),
            )

          ],
        ),

      )
    );
  }
}




                 


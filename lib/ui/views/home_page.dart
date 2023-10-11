import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                 child: Center(child: Text('Faça um novo descarte!', style: TextStyle(fontSize: 20),)),
                 margin: const EdgeInsets.only(top:16),
                 height: 170,
                 width: 350,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(5),
                 ),

                 /*child: const SizedBox(
                   width: 350,
                   height: 40, )*/



                ),


            Image.asset('assets/medicine-bro.gif', height: 250,),



            const SizedBox(
              width: 350,
              height: 40,
                child: Text(
                 'A preservação do meio ambiente começa com pequenas atitudes '
                     'diárias.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                width: 350,
                height: 40,
                child: Text(
                    'Comece a descartar medicamentos de forma consciente agora'
                        ' mesmo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
              ),

              ElevatedButton(

                onPressed: () {Navigator.pushNamed(context, '/descarte');},

                child: const Text('Iniciar novo descarte'),
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




                 


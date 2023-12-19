import 'dart:math';

import 'package:decarte_bem/ui/views/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionsBar extends StatefulWidget {
  final Function updateHome;
  const ActionsBar({Key? key, required this.updateHome}) : super(key: key);

  @override
  State<ActionsBar> createState() => _ActionsBarState();
}

class _ActionsBarState extends State<ActionsBar> {

  Future<void> launchAssFaQQUrl() async {
    dynamic url = Uri.parse('https://assistenciafarmaceutica.uff.br/');
    await launchUrl(url);
  }


  Widget actionButton(String text, IconData? icon, Function() onPressed, bool active){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double size = sqrt((width * width) + (height * height));

    return Padding(
      padding: EdgeInsets.only(top: height/150, bottom: height/100, left: width/50, right: width/50),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: active == true ? Colors.teal.shade200 : Colors.grey,
          ),
          width: width/4,
          height: height/9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Icon(icon, color: Colors.white, size: size/25) :
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SvgPicture.asset(
                  'assets/AssFaQQ.svg',
                  height: size/25,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size/75,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;

    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.teal.shade800,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(wid/50),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Ações',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width/20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              actionButton('Instruções para descarte', Icons.recycling, (){}, false),
              actionButton('Mapa (locais de descarte)', Icons.map_rounded, (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage(updateHome: (){
                    widget.updateHome();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },))
                );

              }, true),
              actionButton('Histórico de descartes', Icons.history_sharp, (){}, false),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              actionButton('Perguntas frequentes', Icons.question_mark, (){
                Navigator.pushNamed(context, '/FAQ');
              }, true),
              actionButton('Saiba mais em AssFaQQ', null, launchAssFaQQUrl, true),
            ],
          )


        ]
      ),

    );
  }
}

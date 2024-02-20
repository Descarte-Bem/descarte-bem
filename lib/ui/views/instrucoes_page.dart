import 'package:decarte_bem/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class InstrucoesPage extends StatefulWidget {
  const InstrucoesPage({Key? key}) : super(key: key);

  @override
  State<InstrucoesPage> createState() => _InstrucoesPageState();
}

class _InstrucoesPageState extends State<InstrucoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: CustomAppBar(context: context,),
      body: ListView(
            children: [
               Container(
                   margin: const EdgeInsets.only(top: 8, bottom:
                   12),

                child: Column(
                  children: [

                  Text('Descarte de medicamentos',
                  style: TextStyle(
                    fontSize: 24,
                    )),

                  Text('Preparo do descarte',
                  style: TextStyle(
                    fontSize: 18,
                  )),
                  ])),

              Text('1. Para iniciar, separe em casa os materiais para descarte',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),),

              Container(
                  margin: const EdgeInsets.all(7),
                child: const Column(
                    children: [
                      Text('a. Medicamentos vencidos'),
                      Text('b. Medicamentos que não serão mais utilizados'),
                      Text('c. Embalagens de medicamentos finalizados'),
                      Text('d. Medicamentos ‘soltos’, fora da embalagem'),
                      Text('e. Embalagens secundárias de medicamentos'),
                      Text('d. Bulas'),
              ])),

              Text('2. Ainda em domicílio, separe as embalagens primárias (com ou sem sobra de medicamentos) das bulas e embalagens secundárias.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),),
              Text('As embalagens primárias são aquelas que ficam em contato direto com o medicamento, sendo alguns exemplos os blisters de comprimidos, frasco conta-gotas e flaconetes para medicamentos líquidos, sachês para medicamentos em pó e bisnagas para géis e pomadas.'),
              Text('Mesmo as embalagens que tenham sido utilizadas por completo devem ser descartadas neste grupo, pois os resquícios do medicamento permanecem aderidos ao material de embalagem e devem ser tratados de forma especial no descarte.',
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),),
              Text('As embalagens secundárias não têm contato direto com o medicamento, sendo utilizadas para a proteção do medicamento durante o seu transporte e armazenamento. Junto com as embalagens secundárias devem ser separadas as bulas também para descarte. Por não entrarem em contato com o medicamento, estes materiais podem ser encaminhados para reciclagem comum, mas os pontos de coleta de medicamentos também possuem bombonas para estes materiais.'),

              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text('3. Com os materiais para descarte separados nestes dois grupos mencionados acima, dirija-se ao ponto de coleta mais próximo de seu domicílio.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),),
              ),
            ],
          )

          );

  }
}
import 'package:decarte_bem/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<String> questions = [
    'Descartar medicamentos vencidos reduz riscos à saúde?',
    'O que eu posso fazer para reduzir a quantidade de medicamentos a serem descartados e reduzir o desperdício de medicamentos?',
    'Posso descartar os medicamentos no vaso sanitário?',
    'Posso diluir o medicamento e descartar na pia?',
    'Quais os impactos de descartar medicamentos em lixo comum?',
    'O que é feito com os medicamentos descartados adequadamente?',
    'Quais os cuidados para armazenar medicamentos e não ter que descartá-lo antes do prazo?',
    'O que diz a legislação sobre o descarte de medicamentos?',
    'Ao transportar medicamentos, quais os cuidados para que não estraguem e seja preciso descartá-lo?',
    'O que é Logística Reversa?',
    'Como devo guardar meus medicamentos em casa para que eles não percam a eficácia?',
  ];

  List<String> answers = [
    'Sim, o descarte adequado de medicamentos vencidos é essencial para a redução dos riscos à saúde e ao meio ambiente. Medicamentos vencidos perdem eficácia e tornam-se perigosos para o uso. Por isso, é importante descartá-los de maneira correta a fim de evitar tais riscos.',
    'Adquira somente a quantidade necessária e evite estocar ou acumular medicamentos que não serão utilizados. Evite adquirir mais do que o necessário, apenas por precaução, certo?',
    'Não. O descarte de medicamentos no vaso sanitário pode contaminar o lençol freático e o solo, causando danos significativos a longo prazo. Vale ressaltar que, normalmente, o tratamento de esgoto não elimina completamente as substâncias químicas presentes nos medicamentos.',
    'Não. Isso pode levar à contaminação do solo, da água em rios, lagos e até mesmo do lençol freático, afetando assim não só a vida humana, mas também os organismos que vivem nesses ambientes aquáticos e terrestres.',
    'Descartar medicamentos no lixo comum pode resultar em contaminação do solo, acarretando diversos riscos à saúde humana e danos ao meio ambiente. Além disso, representa um perigo para a segurança de crianças, animais e outros indivíduos que podem encontrar e fazer uso dos medicamentos sem conhecimento dos perigos associados.',
    'Empresas especializadas em gerenciamento de resíduos realizam a coleta destes medicamentos que, após passarem por um processo de separação e tratamento, podem ser incinerados.',
    'Armazene em local fresco e seco, sempre de acordo com as instruções da bula. Mantenha os medicamentos em sua embalagem original. Certifique-se de armazená-los fora do alcance de crianças e animais domésticos, e sempre verifique a data de validade e se houve alteração de cor ou odor, antes de fazer o uso.',
    'A legislação, representada pelo Decreto No 10.388 de 2020, estabelece que drogarias e farmácias são obrigadas a disponibilizar pontos de coleta para recebimento de medicamentos vencidos. Isso visa garantir para você, consumidor, locais apropriados para descartar os medicamentos de forma segura, contribuindo assim para a preservação ambiental e prevenção de riscos à saúde pública.',
    'Proteja seus medicamentos contra mudanças de temperatura. Certifique-se de que eles não fiquem expostos ao calor excessivo ou frio. Se estiver transportando medicamentos que precisam ser refrigerados, coloque-os em um isopor apropriado ou em uma bolsa térmica com gelo reutilizável rígido (mantido previamente por mais de 12 horas em congelador). Proteja os medicamentos contra impactos ou danos, mantendo em suas embalagens originais dentro de uma caixa ou bolsa acolchoada.',
    'Quando você, consumidor, descarta medicamentos vencidos ou impróprios para o uso nos pontos de coleta, as farmácias e drogarias assumem a responsabilidade de devolvê-los aos fabricantes por meio da Logística Reversa. A Logística Reversa transfere a responsabilidade do descarte adequado para os produtores. Isso significa que eles devem implementar métodos que garantam a coleta e o tratamento apropriado desses produtos, contribuindo assim para a preservação ambiental e para a saúde.',
    'Para manter a eficácia dos medicamentos em casa:\n\t\t\t-\tArmazene-os em local fresco, seco e protegido da luz solar e umidade.\n\t\t\t-\tMantenha os medicamentos em sua embalagem original.\n\t\t\t-\tVerifique regularmente a data de validade, mudanças de cor ou odor.\n\t\t\t-\tNão guarde perto de fontes de calor ou umidade, como ocorre no banheiro e na cozinha.\n\t\t\t-\tSe necessário refrigeração, não armazene próximo ao congelador ou na porta da geladeira.'
  ];

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: CustomAppBar(
        context: context,
        autoLeading: true,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: hei/75, bottom: hei/75),
            child: ExpansionTile(
              textColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.teal.shade100,
              title: Text(
                questions[index],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: hei/45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: hei/50, right: hei/50, bottom: hei/75),
                  child: Text(
                    answers[index],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: hei/60,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quizyz/components/answer_component.dart';
import 'package:quizyz/components/quizyz_app_button.dart';

class GamePage extends StatefulWidget {
  final String title;

  GamePage({@required this.title});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Widget> answerList = [
    AnswerComponent(
      answer: "Picanha",
    ),
    AnswerComponent(
      answer: "Lasanha",
    ),
    AnswerComponent(
      answer: "Bolo de laranja",
    ),
    AnswerComponent(
      answer: "Macarrão",
    )
  ];

  /* 
    Imagino que as perguntas virão em formato de lista... 
    Se for o caso podemos fazer a barra de progressão baseada no index dela.
    A partir dai para fazer a animação de progressão podemos fazer um calculo
    Para obter a porcetagem do index da lista e move-lá a partir dai. 

    Ainda pensando em como fazer *este* componente de resposta de uma forma
    Satisfatoria... Pensei nele ser hardcoded para 4 respostas mas não fiquei 
    Feliz com esta aproximação então fiz justamente ao contrario... 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Theme.of(context).accentColor, fontSize: 22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 32.0, right: 16.0, left: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Qual minha comida favorita?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 26, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 32.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: answerList[index],
                  );
                },
                itemCount: answerList.length,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 42.0, left: 16.0, right: 16.0),
                child: QuizyzAppButton(
                  title: "Proximo",
                  onTap: () => null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

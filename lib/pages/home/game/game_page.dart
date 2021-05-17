import 'package:flutter/material.dart';
import 'package:quizyz/components/answer_component.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/model/Pergunta.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/Resposta.dart';

class GamePage extends StatefulWidget {
  final String title;
  final Quiz quiz;

  GamePage({@required this.title, this.quiz});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final key = new GlobalKey<AnswerComponentState>();
  // Para teste apenas
  List<Pergunta> perguntaList = [
    Pergunta(
      titulo: "Qual minha comida favorita?",
      resposta: [
        Resposta(titulo: "Hamburguer", resposta: false),
        Resposta(titulo: "Pizza", resposta: false),
        Resposta(titulo: "Curry", resposta: true),
        Resposta(titulo: "Lasanha", resposta: false)
      ],
    ),
    Pergunta(
      titulo: "Qual minha bebida favorita?",
      resposta: [
        Resposta(titulo: "Cerveja", resposta: false),
        Resposta(titulo: "Energetico", resposta: false),
        Resposta(titulo: "Suco de abacaxi", resposta: true),
        Resposta(titulo: "Lasanha", resposta: false)
      ],
    ),
  ];

  int ponteiro = 0;

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
                perguntaList[ponteiro].titulo,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 26, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 32.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: AnswerComponent(
                respostas: perguntaList[ponteiro].resposta,
                key: key,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 42.0, left: 16.0, right: 16.0),
                child: QuizyzAppButton(
                  title: "Proximo",
                  onTap: () => setState(
                    () {
                      key.currentState.showAnswer = true;

                      Future.delayed(
                        Duration(seconds: 5),
                        () {
                          if (ponteiro < perguntaList.length - 1) {
                            setState(() {
                              key.currentState.showAnswer = false;
                              ponteiro++;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

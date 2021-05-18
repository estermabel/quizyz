import 'package:flutter/material.dart';
import 'package:quizyz/components/answer_component.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/model/Pergunta.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/Resposta.dart';
import 'package:quizyz/utils/style/colors.dart';

class GamePage extends StatefulWidget {
  final String jogadorNome;
  final Quiz quiz;

  GamePage({@required this.jogadorNome, this.quiz});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  final key = new GlobalKey<AnswerComponentState>();
  AnimationController _controller;
  int ponteiro = 0;
  double appBarProgress = 0.0;
  bool runFunction = true;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 5),
        value: appBarProgress);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // Para teste apenas
  List<Pergunta> perguntaList = [
    Pergunta(
      titulo: "Qual minha comida favorita?",
      respostas: [
        Resposta(titulo: "Hamburguer", isCerta: false),
        Resposta(titulo: "Pizza", isCerta: false),
        Resposta(titulo: "Curry", isCerta: true),
        Resposta(titulo: "Lasanha", isCerta: false)
      ],
    ),
    Pergunta(
      titulo: "Qual minha bebida favorita?",
      respostas: [
        Resposta(titulo: "Cerveja", isCerta: false),
        Resposta(titulo: "Energetico", isCerta: false),
        Resposta(titulo: "Suco de abacaxi", isCerta: true),
        Resposta(titulo: "Lasanha", isCerta: false)
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.quiz.titulo,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Theme.of(context).accentColor, fontSize: 22),
        ),
        leading: IconButton(
          icon: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(
                  color: accentColor,
                ),
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: _controller.value,
            valueColor: AlwaysStoppedAnimation<Color>(blueColor),
            minHeight: 2,
          ),
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
                respostas: perguntaList[ponteiro].respostas,
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
                  onTap: () {
                    if (runFunction == true) {
                      if (key.currentState.radioIndex != null) {
                        setState(() {
                          key.currentState.showAnswer = true;
                          runFunction = !runFunction;
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          if (ponteiro < perguntaList.length - 1) {
                            setState(() {
                              runFunction = !runFunction;
                              key.currentState.showAnswer = false;
                              key.currentState.radioIndex = null;

                              ponteiro++;
                              animateAppProgress();
                            });
                          } else {
                            animateAppProgress();
                            showSnackBarWithMessage(context, "Fim da lista :3");
                          }
                        });
                      } else {
                        showSnackBarWithMessage(
                            context, "Escolha uma alternativa");
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBarWithMessage(BuildContext context, String mensage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensage),
      ),
    );
  }

  void animateAppProgress() {
    appBarProgress = appBarProgress + 0.1;
    _controller.animateTo(appBarProgress,
        duration: Duration(milliseconds: 1000));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizyz/bloc/game_flow_bloc.dart';

import 'package:quizyz/bloc/score_bloc.dart';
import 'package:quizyz/components/answer_component.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/pages/home/game/ranking_page.dart';
import 'package:quizyz/pages/login_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

import '../../controller_page.dart';

class GamePage extends StatefulWidget {
  final String jogadorNome;
  final Quiz quiz;
  final bool isLogged;
  final bool isTutorial;

  GamePage(
      {@required this.jogadorNome,
      this.quiz,
      this.isLogged,
      this.isTutorial = false});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  GameFlowBloc _bloc = GameFlowBloc();

  final key = new GlobalKey<AnswerComponentState>();
  int ponteiro = 0;
  double appBarProgress = 0.0;
  bool runFunction = true;
  int quantidadeDePerguntas;
  int pontuacao = 0;

  @override
  void initState() {
    quantidadeDePerguntas = widget.quiz.perguntas.length + 1;
    super.initState();
  }

  _finishGame() async {
    Jogador jogador = Jogador(
      nome: widget.jogadorNome,
      pontuacao: pontuacao,
    );

    _gameStream();
    widget.isTutorial
        ? ManagerDialogs.showMessageDialog(
            context,
            "Você concluiu o tutorial!",
            widget.isLogged
                ? () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ControllerPage(),
                        ),
                        (route) => false);
                  }
                : null,
            false,
          )
        : await _bloc.addJogador(
            jogador: jogador,
            quiz: widget.quiz,
          );
  }

  _gameStream() async {
    _bloc.gameStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (context) => RankingPage(
                hasAppBar: false,
                hasButtom: true,
                quiz: widget.quiz,
                textButtom: widget.isLogged
                    ? "Voltar para Home"
                    : "Voltar para o Login",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          widget.isLogged ? ControllerPage() : LoginPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          );

          break;
        case Status.LOADING:
          ManagerDialogs.showLoadingDialog(context);
          break;
        case Status.ERROR:
          Navigator.pop(context);
          ManagerDialogs.showErrorDialog(context, event.message);
          break;
        default:
          break;
      }
    });
  }

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
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width,
            lineHeight: 4.0,
            percent: animateAppProgress(),
            backgroundColor: whiteColor,
            progressColor: blueColor,
            animation: true,
            animationDuration: 30,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 32.0, right: 16.0, left: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.quiz.perguntas[ponteiro].titulo,
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
                  respostas: widget.quiz.perguntas[ponteiro].respostas,
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
                          Future.delayed(Duration(seconds: 2), () async {
                            if (ponteiro < widget.quiz.perguntas.length - 1) {
                              setState(() {
                                runFunction = !runFunction;
                                calculateScore();
                                key.currentState.showAnswer = false;
                                key.currentState.radioIndex = null;

                                ponteiro++;
                              });
                            } else {
                              calculateScore();
                              await _finishGame();
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Escolha uma alternativa!",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              backgroundColor: bottomNavBarBackgroundColor,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
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

  double animateAppProgress() {
    if (quantidadeDePerguntas <= 1) {
      return 1.0;
    }

    if (quantidadeDePerguntas == widget.quiz.perguntas.length + 1) {
      --quantidadeDePerguntas;
      return 0.0;
    }

    double quantidade = 100 / --quantidadeDePerguntas;

    print("Quantidade de perguntas $quantidadeDePerguntas");

    print("Quantidade divido por 100 ${quantidade / 100}");

    return quantidade / 100;
  }

  void calculateScore() {
    for (int i = 0; i < widget.quiz.perguntas[ponteiro].respostas.length; i++) {
      if (widget.quiz.perguntas[ponteiro].respostas[i].isCerta) {
        if (i == key.currentState.radioIndex) {
          pontuacao++;
          break;
        }
      }
    }
    print("Pontuação -> $pontuacao");
  }
}

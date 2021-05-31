import 'package:flutter/material.dart';
import 'package:quizyz/bloc/play_bloc.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/db/quiz_tutorial.dart';
import 'package:quizyz/pages/home/game/game_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class PlayPage extends StatefulWidget {
  final bool hasLeading;

  const PlayPage({Key key, this.hasLeading = false}) : super(key: key);
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  PlayBloc _bloc = PlayBloc();
  bool _isCodeErrorDisplayed = false;
  bool _isNomeJogadorErrorDisplayed = false;
  bool isLogged;

  @override
  void initState() {
    super.initState();
    _bloc.getUsuarioLogin();
    _startGameStream();
    checkIfUserIsLogged();
  }

  checkIfUserIsLogged() async {
    _bloc.isLoggedStream.listen((event) async {
      isLogged = event;
      if (event) {
        _bloc.nomeJogadorController.text = await _bloc.getUsuarioNome();
      }
      setState(() {});
    });
  }

  _startGame() async {
    await _bloc.getQuiz(cod: int.parse(_bloc.codeController.text));
  }

  _startGameStream() async {
    _bloc.playQuizStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                jogadorNome: _bloc.nomeJogadorController.text,
                quiz: event.data,
                isLogged: isLogged,
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
          "Jogar",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
        leading: widget.hasLeading
            ? IconButton(
                icon: IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(
                        color: accentColor,
                      ),
                  child: Icon(Icons.arrow_back_ios),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () {
          ManagerDialogs.showMessageDialog(
            context,
            "Para entender o jogo, deseja jogar o quiz tutorial?",
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GamePage(
                      jogadorNome: _bloc.nomeJogadorController.text,
                      quiz: QuizTutorial.quiz,
                      isLogged: !widget.hasLeading,
                      isTutorial: true,
                    );
                  },
                ),
              );
            },
            true,
          );
        },
        child: Text(
          "?",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: StreamBuilder<bool>(
                stream: _bloc.isLoggedStream,
                initialData: true,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          (snapshot.data)
                              ? "Insira o código do quiz para poder jogar."
                              : "Insira seu nome e o código do quiz para poder jogar.",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Form(
                          key: _bloc.formKey,
                          child: Column(
                            children: [
                              Visibility(
                                visible: !snapshot.data,
                                child: TextFormField(
                                  controller: _bloc.nomeJogadorController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  cursorColor: whiteColor,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  validator: (value) {
                                    if (_bloc
                                        .nomeJogadorController.text.isEmpty) {
                                      _isNomeJogadorErrorDisplayed = true;
                                      return "Campo de código vazio!";
                                    }
                                    _isNomeJogadorErrorDisplayed = false;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: TextFormField(
                                  controller: _bloc.codeController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  keyboardType: TextInputType.number,
                                  cursorColor: whiteColor,
                                  decoration: InputDecoration(
                                    labelText: "Código",
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  validator: (value) {
                                    if (_bloc.codeController.text.isEmpty) {
                                      _isCodeErrorDisplayed = true;
                                      return "Campo de código vazio!";
                                    }
                                    _isCodeErrorDisplayed = false;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 120),
                                child: QuizyzAppButton(
                                  title: "Jogar",
                                  onTap: () async {
                                    if (_bloc.formKey.currentState.validate()) {
                                      _startGame();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

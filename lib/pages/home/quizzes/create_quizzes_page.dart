import 'package:flutter/material.dart';
import 'package:quizyz/bloc/create_quiz_bloc.dart';
import 'package:quizyz/components/create_quiz_card.dart';
import 'package:quizyz/components/purple_button.dart';
import 'package:quizyz/model/Pergunta.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/Resposta.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class CreateQuizzesPage extends StatefulWidget {
  final User criador;

  const CreateQuizzesPage({Key key, this.criador}) : super(key: key);

  @override
  _CreateQuizzesPageState createState() => _CreateQuizzesPageState();
}

class _CreateQuizzesPageState extends State<CreateQuizzesPage> {
  CreateQuizBloc _bloc = CreateQuizBloc();
  List<CreateQuizCard> quizesList = [];

  @override
  void initState() {
    _createQuizStream();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  _createQuizStream() async {
    _bloc.createQuizStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          Navigator.pop(context);
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
          "Criar quiz",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).accentColor,
              ),
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
        actions: [
          IconButton(
              icon: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(Icons.check),
              ),
              onPressed: () async {
                if (quizesList.length > 0) {
                  List<Pergunta> perguntas = [];
                  bool runBloc = true;
                  // TODO: Fix para bug estranho na criação de quiz
                  for (int i = 0; i < quizesList.length; i++) {
                    if (_bloc.tituloController.text.isNotEmpty &&
                        quizesList[i].perguntaController.text.isNotEmpty &&
                        quizesList[i].resposta1Controller.text.isNotEmpty &&
                        quizesList[i].resposta2Controller.text.isNotEmpty &&
                        quizesList[i].resposta3Controller.text.isNotEmpty &&
                        quizesList[i].resposta4Controller.text.isNotEmpty) {
                      perguntas.add(Pergunta(
                        titulo: quizesList[i].perguntaController.text,
                        respostas: [
                          Resposta(
                              id: 1,
                              isCerta: false,
                              titulo: quizesList[i].resposta1Controller.text),
                          Resposta(
                              id: 2,
                              isCerta: false,
                              titulo: quizesList[i].resposta2Controller.text),
                          Resposta(
                              id: 3,
                              isCerta: false,
                              titulo: quizesList[i].resposta3Controller.text),
                          Resposta(
                              id: 4,
                              isCerta: false,
                              titulo: quizesList[i].resposta4Controller.text)
                        ],
                      ));
                      for (var respostas in perguntas[i].respostas) {
                        if (respostas.id == quizesList[i].value) {
                          respostas.isCerta = true;
                          break;
                        }
                      }
                    } else {
                      runBloc = false;
                      return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Preencha o quiz!",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          backgroundColor: bottomNavBarBackgroundColor,
                        ),
                      );
                    }
                  }

                  if (runBloc == true) {
                    Quiz quiz = Quiz(
                      titulo: _bloc.tituloController.text,
                      perguntas: perguntas,
                      criador: widget.criador,
                    );

                    await _bloc.createQuiz(quiz: quiz);
                  }
                }
              }),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                controller: _bloc.tituloController,
                decoration: InputDecoration(
                  labelText: "Titulo",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return quizesList[index];
                  },
                  itemCount: quizesList.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: quizesList.length < 10
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: quizesList.length < 10 ? true : false,
                        child: PurpleButton(
                          titulo: "Adicionar pergunta",
                          onTap: () {
                            if (quizesList.length < 10) {
                              setState(
                                () {
                                  int size = quizesList.length + 1;
                                  quizesList.add(
                                    CreateQuizCard(
                                      pergunta: "Pergunta " + size.toString(),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      quizesList.length >= 10
                          ? PurpleButton(
                              titulo: "Remover Pergunta",
                              onTap: () => setState(() => quizesList.length > 0
                                  ? quizesList.removeLast()
                                  : null),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 35,
                              ),
                              onPressed: () => setState(() =>
                                  quizesList.length > 0
                                      ? quizesList.removeLast()
                                      : null),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

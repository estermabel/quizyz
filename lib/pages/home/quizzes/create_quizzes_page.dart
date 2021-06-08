import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/bloc/create_quiz_bloc.dart';
import 'package:quizyz/bloc/quizzes_bloc.dart';
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
            ManagerDialogs.showMessageDialog(
              context,
              "Deseja sair dessa tela?",
              () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              true,
            );
          },
        ),
        actions: [
          Tooltip(
            message: 'Apagar pergunta',
            decoration: BoxDecoration(
              color: bottomNavBarBackgroundColor,
            ),
            child: IconButton(
              icon: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(Icons.delete),
              ),
              onPressed: () => setState(
                () => quizesList.length > 0 ? quizesList.removeLast() : null,
              ),
            ),
          ),
          Tooltip(
            message: 'Criar quiz',
            decoration: BoxDecoration(
              color: bottomNavBarBackgroundColor,
            ),
            child: IconButton(
              icon: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(Icons.check),
              ),
              onPressed: () async {
                ManagerDialogs.showMessageDialog(
                  context,
                  "Deseja criar o quiz?",
                  () async {
                    if (quizesList.length > 0) {
                      List<Pergunta> perguntas = [];
                      bool runBloc = true;
                      for (int i = 0; i < quizesList.length; i++) {
                        if (_bloc.tituloController.text.isNotEmpty &&
                            quizesList[i].perguntaController.text.isNotEmpty &&
                            quizesList[i].resposta1Controller.text.isNotEmpty &&
                            quizesList[i].resposta2Controller.text.isNotEmpty &&
                            quizesList[i].resposta3Controller.text.isNotEmpty &&
                            quizesList[i].resposta4Controller.text.isNotEmpty) {
                          perguntas.add(
                            Pergunta(
                              titulo: quizesList[i].perguntaController.text,
                              respostas: [
                                Resposta(
                                  id: 1,
                                  isCerta: false,
                                  titulo:
                                      quizesList[i].resposta1Controller.text,
                                ),
                                Resposta(
                                  id: 2,
                                  isCerta: false,
                                  titulo:
                                      quizesList[i].resposta2Controller.text,
                                ),
                                Resposta(
                                  id: 3,
                                  isCerta: false,
                                  titulo:
                                      quizesList[i].resposta3Controller.text,
                                ),
                                Resposta(
                                  id: 4,
                                  isCerta: false,
                                  titulo:
                                      quizesList[i].resposta4Controller.text,
                                )
                              ],
                            ),
                          );
                          for (var respostas in perguntas[i].respostas) {
                            if (respostas.id == quizesList[i].value) {
                              respostas.isCerta = true;
                              break;
                            }
                          }
                          print(perguntas.length);
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

                        await _bloc.createQuiz(quiz: quiz).then(
                              (value) => Navigator.pop(context),
                            );
                      }
                    }
                  },
                  true,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Tooltip(
        message: 'Adicionar pergunta',
        decoration: BoxDecoration(
          color: bottomNavBarBackgroundColor,
        ),
        child: FloatingActionButton(
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(
                  color: whiteColor,
                ),
            child: Icon(Icons.add),
          ),
          onPressed: quizesList.length < 10
              ? () {
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
                }
              : null,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Titulo",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return quizesList[index];
                },
                itemCount: quizesList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

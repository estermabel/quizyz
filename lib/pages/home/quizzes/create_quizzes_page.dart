import 'package:flutter/material.dart';
import 'package:quizyz/bloc/create_quiz_bloc.dart';
import 'package:quizyz/components/create_quiz_card.dart';
import 'package:quizyz/components/purple_button.dart';
import 'package:quizyz/utils/style/colors.dart';

class CreateQuizzesPage extends StatefulWidget {
  @override
  _CreateQuizzesPageState createState() => _CreateQuizzesPageState();
}

class _CreateQuizzesPageState extends State<CreateQuizzesPage> {
  CreateQuizBloc _bloc = CreateQuizBloc();
  List<CreateQuizCard> quizesList = [];

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
            onPressed: () {
              if (quizesList.length > 0) {
                quizesList.forEach((element) {
                  if (_bloc.tituloController.text.isNotEmpty &&
                      element.perguntaController.text.isNotEmpty &&
                      element.resposta1Controller.text.isNotEmpty &&
                      element.resposta2Controller.text.isNotEmpty &&
                      element.resposta3Controller.text.isNotEmpty &&
                      element.resposta4Controller.text.isNotEmpty) {
                    // TODO: Criar objeto aqui.

                  } else {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Preencha o quiz!"),
                      ),
                    );
                  }
                });
              }
            },
          ),
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

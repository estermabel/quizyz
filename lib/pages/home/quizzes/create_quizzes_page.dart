import 'package:flutter/material.dart';
import 'package:quizyz/bloc/create_quiz_bloc.dart';
import 'package:quizyz/components/create_quiz_card.dart';
import 'package:quizyz/components/purple_button.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class CreateQuizzesPage extends StatefulWidget {
  @override
  _CreateQuizzesPageState createState() => _CreateQuizzesPageState();
}

class _CreateQuizzesPageState extends State<CreateQuizzesPage> {
  CreateQuizBloc _bloc = CreateQuizBloc();
  List<Widget> quizesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Criar quiz",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).accentColor),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (quizesList.length > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Quiz criado."),
                    ),
                  );
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 32.0, right: 16.0),
              child: TextField(
                controller: _bloc.tituloController,
                decoration: InputDecoration(
                  labelText: "Titulo",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return quizesList[index];
                  },
                  itemCount: quizesList.length,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 32.0, right: 16, left: 16),
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
            )
          ],
        ),
      ),
    );
  }
}

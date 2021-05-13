import 'package:flutter/material.dart';
import 'package:quizyz/components/create_quiz_card.dart';
import 'package:quizyz/components/purple_button.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class CreateQuizzesPage extends StatefulWidget {
  @override
  _CreateQuizzesPageState createState() => _CreateQuizzesPageState();
}

class _CreateQuizzesPageState extends State<CreateQuizzesPage> {
  List<Widget> quizesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Criar quiz",
          style: baseTheme.textTheme.headline1
              .copyWith(color: baseTheme.accentColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 38.0, top: 16, right: 16, left: 16),
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
                  titulo: quizesList.length < 10
                      ? "Adicionar quiz"
                      : "Cadastrar Quiz",
                  onTap: () => setState(
                    () {
                      if (quizesList.length < 10) {
                        int size = quizesList.length + 1;
                        quizesList.add(
                          CreateQuizCard(
                            pergunta: "Pergunta " + size.toString(),
                          ),
                        );
                      } else {
                        // Cadastrar quiz aqui?

                      }
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

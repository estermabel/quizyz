import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class CreateQuizCard extends StatefulWidget {
  final String pergunta;

  CreateQuizCard({@required this.pergunta});

  @override
  _CreateQuizCardState createState() => _CreateQuizCardState();
}

class _CreateQuizCardState extends State<CreateQuizCard> {
  bool teste = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Text(
              widget.pergunta,
              style: baseTheme.textTheme.bodyText2,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Nome",
              labelStyle: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: teste,
                  groupValue: teste,
                  onChanged: (value) {
                    setState(() {
                      teste = !teste;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Teste1",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: teste,
                  groupValue: teste,
                  onChanged: (value) {
                    setState(() {
                      teste = !teste;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Teste2",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: teste,
                  groupValue: teste,
                  onChanged: (value) {
                    setState(() {
                      teste = !teste;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Teste3",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: teste,
                  groupValue: teste,
                  onChanged: (value) {
                    setState(() {
                      teste = !teste;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Teste4",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

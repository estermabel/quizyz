import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class CreateQuizCard extends StatefulWidget {
  final String pergunta;

  CreateQuizCard({@required this.pergunta});

  @override
  _CreateQuizCardState createState() => _CreateQuizCardState();
}

class _CreateQuizCardState extends State<CreateQuizCard> {
  // Radio button value
  int _value = 1;

  //TextEdittingController
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _pergunta1Controller = new TextEditingController();
  TextEditingController _pergunta2Controller = new TextEditingController();
  TextEditingController _pergunta3Controller = new TextEditingController();
  TextEditingController _pergunta4Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
            child: Text(
              widget.pergunta,
              style: baseTheme.textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _pergunta1Controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
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
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _pergunta2Controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
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
                  value: 3,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _pergunta3Controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
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
                  value: 4,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _pergunta4Controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
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

import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';

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
  TextEditingController _perguntaController = new TextEditingController();
  TextEditingController _resposta1Controller = new TextEditingController();
  TextEditingController _resposta2Controller = new TextEditingController();
  TextEditingController _resposta3Controller = new TextEditingController();
  TextEditingController _resposta4Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.pergunta,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _perguntaController,
                decoration: InputDecoration(
                  labelText: "Pergunta",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: whiteColor,
                    ),
                    child: Radio(
                      value: 1,
                      groupValue: _value,
                      activeColor: whiteColor,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _resposta1Controller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: whiteColor,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: accentColor,
                          ),
                        ),
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
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: whiteColor,
                    ),
                    child: Radio(
                      value: 2,
                      activeColor: whiteColor,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _resposta2Controller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: accentColor),
                        ),
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
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: whiteColor,
                    ),
                    child: Radio(
                      value: 3,
                      groupValue: _value,
                      activeColor: whiteColor,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _resposta3Controller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: accentColor),
                        ),
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
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: whiteColor,
                    ),
                    child: Radio(
                      value: 4,
                      activeColor: whiteColor,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _resposta4Controller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: accentColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

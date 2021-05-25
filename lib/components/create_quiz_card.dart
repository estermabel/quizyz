import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';

// ignore: must_be_immutable
class CreateQuizCard extends StatefulWidget {
  final String pergunta;

  CreateQuizCard({Key key, @required this.pergunta}) : super(key: key);

  // TextEdittingController
  final TextEditingController perguntaController = new TextEditingController();
  final TextEditingController resposta1Controller = new TextEditingController();
  final TextEditingController resposta2Controller = new TextEditingController();
  final TextEditingController resposta3Controller = new TextEditingController();
  final TextEditingController resposta4Controller = new TextEditingController();

  // Radio button value
  int value = 1;

  @override
  CreateQuizCardState createState() => CreateQuizCardState();
}

class CreateQuizCardState extends State<CreateQuizCard> {
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
                controller: widget.perguntaController,
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
                      groupValue: widget.value,
                      activeColor: whiteColor,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.resposta1Controller,
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
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.resposta2Controller,
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
                      groupValue: widget.value,
                      activeColor: whiteColor,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.resposta3Controller,
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
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.resposta4Controller,
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

import 'package:flutter/material.dart';
import 'package:quizyz/model/Resposta.dart';
import 'package:quizyz/utils/style/colors.dart';

class AnswerComponent extends StatefulWidget {
  final List<Resposta> respostas;

  AnswerComponent({Key key, @required this.respostas}) : super(key: key);

  @override
  AnswerComponentState createState() => AnswerComponentState();
}

class AnswerComponentState extends State<AnswerComponent> {
  int radioIndex;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundContainerColor,
                gradient: widget.respostas[index].isCerta == true &&
                        showAnswer == true
                    ? LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [accentColor, purpleColor],
                      )
                    : null,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: whiteColor,
                ),
                child: RadioListTile(
                  value: index,
                  title: Text(widget.respostas[index].titulo),
                  groupValue: radioIndex,
                  activeColor: whiteColor,
                  onChanged: (value) {
                    setState(() {
                      radioIndex = value;
                    });
                  },
                ),
              ),
            ),
          );
        },
        itemCount: widget.respostas.length,
      ),
    );
  }
}

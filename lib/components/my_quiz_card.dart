import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';

class MyQuizCard extends StatelessWidget {
  final String titulo;
  final int qtdPerguntas;
  final int codigo;
  final Function onTap;
  const MyQuizCard({
    Key key,
    this.titulo,
    this.qtdPerguntas,
    this.codigo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: backgroundContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    titulo,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: blueColor,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$qtdPerguntas perguntas",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: accentColor,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SelectableText(
                          "Cód: $codigo",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(
                Icons.arrow_forward_ios,
              ),
            )
          ],
        ),
      ),
    );
  }
}

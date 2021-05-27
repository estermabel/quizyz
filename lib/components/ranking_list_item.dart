import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';

class RankingListItem extends StatelessWidget {
  final String nomeJogador;
  final int pontosJogador;
  final int qtdPerguntas;
  const RankingListItem({
    Key key,
    this.nomeJogador,
    this.pontosJogador,
    this.qtdPerguntas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nomeJogador,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "$pontosJogador/$qtdPerguntas",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quizyz/bloc/score_bloc.dart';
import 'package:quizyz/components/native_loading.dart';
import 'package:quizyz/components/score_quiz_card.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/pages/home/game/ranking_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  ScoreBloc _bloc = ScoreBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getScore();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Score",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<BaseResponse<List<ScoreQuiz>>>(
                stream: _bloc.scoreStream,
                initialData: BaseResponse.completed(),
                builder: (context, snapshot) {
                  if (snapshot.data.data != null) {
                    switch (snapshot.data?.status) {
                      case Status.LOADING:
                        return _onLoading();
                        break;
                      case Status.ERROR:
                        _onError(snapshot);
                        return Container();
                        break;
                      default:
                        _bloc.scoreQuizzesList.clear();
                        if (snapshot.data?.data != null) {
                          snapshot.data.data.forEach((quiz) {
                            _bloc.scoreQuizzesList.add(
                              ScoreQuizCard(
                                criador: quiz.criador,
                                titulo: quiz.titulo,
                                qtdPerguntas: quiz.totalPerguntas,
                                qtdPontos: quiz.pontos,
                              ),
                            );
                          });
                        }

                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _bloc.scoreQuizzesList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: _bloc.scoreQuizzesList[index],
                              );
                            },
                          ),
                        );
                    }
                  } else {
                    return _onLoading();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _onLoading() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: NativeLoading(animating: true),
    );
  }

  Widget _onError(AsyncSnapshot snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ManagerDialogs.showErrorDialog(
        context,
        snapshot.data.message,
      );
    });
  }
}

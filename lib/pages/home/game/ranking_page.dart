import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizyz/bloc/ranking_bloc.dart';
import 'package:quizyz/components/native_loading.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/components/ranking_list_item.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class RankingPage extends StatefulWidget {
  final Quiz quiz;
  final bool hasAppBar;
  final String textButtom;
  final Function onTap;
  final bool hasButtom;

  const RankingPage(
      {Key key,
      this.quiz,
      this.hasAppBar,
      this.textButtom,
      this.onTap,
      this.hasButtom})
      : super(key: key);
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  RankingBloc _bloc = RankingBloc();

  @override
  void initState() {
    super.initState();
    _jogadoresStream();
    _deleteQuizStream();
    _bloc.getJogadoresQuiz(cod: widget.quiz.id);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _jogadoresStream() async {
    _bloc.jogadoresStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          break;
        case Status.LOADING:
          ManagerDialogs.showLoadingDialog(context);
          break;
        case Status.ERROR:
          Navigator.pop(context);
          ManagerDialogs.showErrorDialog(context, event.message);
          break;
        default:
          break;
      }
    });
  }

  _deleteQuizStream() {
    _bloc.quizStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          break;
        case Status.LOADING:
          ManagerDialogs.showLoadingDialog(context);
          break;
        case Status.ERROR:
          Navigator.pop(context);
          Navigator.pop(context);
          ManagerDialogs.showErrorDialog(context, event.message);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hasAppBar
          ? AppBar(
              centerTitle: true,
              title: Text(
                widget.quiz.titulo,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: accentColor,
                    ),
              ),
              leading: IconButton(
                icon: IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(
                        color: accentColor,
                      ),
                  child: Icon(Icons.arrow_back_ios),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                GestureDetector(
                  onTap: widget.onTap == null
                      ? () async {
                          await _bloc.deleteQuiz(cod: widget.quiz.id);
                        }
                      : widget.onTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: IconTheme(
                      data: Theme.of(context).iconTheme.copyWith(
                            color: accentColor,
                          ),
                      child: Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                child: SvgPicture.asset(
                  "images/trophy.svg",
                  alignment: Alignment.center,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Ranking",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SelectableText(
                "Cod: ${widget.quiz.id}",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 72, 64, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<BaseResponse<List<Jogador>>>(
                    stream: _bloc.jogadoresStream,
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
                            _bloc.jogadoresList.clear();
                            if (snapshot.data?.data != null) {
                              snapshot.data.data.forEach(
                                (jogador) {
                                  _bloc.jogadoresList.add(jogador);
                                },
                              );
                            }

                            return Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _bloc.jogadoresList?.length,
                                itemBuilder: (context, index) {
                                  return RankingListItem(
                                    nomeJogador:
                                        _bloc.jogadoresList[index].nome,
                                    pontosJogador:
                                        _bloc.jogadoresList[index].pontuacao,
                                    qtdPerguntas: widget.quiz.perguntas.length,
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
                  widget.hasButtom
                      ? Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: QuizyzAppButton(
                            onTap: widget.onTap,
                            title: widget.textButtom,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/bloc/quizzes_bloc.dart';
import 'package:quizyz/components/native_loading.dart';
import 'package:quizyz/components/my_quiz_card.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/pages/home/game/ranking_page.dart';
import 'package:quizyz/pages/home/quizzes/create_quizzes_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

import '../../login_page.dart';

class QuizzesPage extends StatefulWidget {
  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  QuizzesBloc _bloc = QuizzesBloc();
  User user;

  @override
  void initState() {
    super.initState();
    getUser();
    _quizzesStream();
    _bloc.getQuizzes();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void getUser() async {
    user = await _bloc.getUser();
  }

  _quizzesStream() async {
    _bloc.quizzesStream.listen((event) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Meus Quizyz",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _bloc.getUser();
              _bloc.getQuizzes();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(
                  Icons.refresh,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await CustomSharedPreferences.saveUsuario(false);
              await CustomSharedPreferences.saveId(0);
              await CustomSharedPreferences.saveNomeUsuario("nome");
              _bloc.deleteDB();
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(
                  Icons.exit_to_app_rounded,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateQuizzesPage(criador: user),
          ),
        ),
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(color: whiteColor),
          child: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<String>(
                stream: _bloc.userStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Text(
                      "Oie ${snapshot.data},",
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              StreamBuilder<BaseResponse<List<Quiz>>>(
                stream: _bloc.quizzesStream,
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
                        _bloc.meusQuizzesList.clear();
                        if (snapshot.data?.data != null) {
                          snapshot.data.data.forEach(
                            (quiz) {
                              _bloc.meusQuizzesList.add(
                                MyQuizCard(
                                  codigo: quiz.id,
                                  titulo: quiz.titulo,
                                  qtdPerguntas: quiz.perguntas.length,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RankingPage(
                                        quiz: quiz,
                                        hasAppBar: true,
                                        textButtom: "",
                                        hasButtom: false,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _bloc.meusQuizzesList?.length,
                            itemBuilder: (context, index) {
                              return _bloc.meusQuizzesList[index];
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

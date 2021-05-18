import 'package:flutter/material.dart';
import 'package:quizyz/bloc/play_bloc.dart';
import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/pages/home/game/game_page.dart';
import 'package:quizyz/utils/style/colors.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  PlayBloc _bloc = PlayBloc();
  bool _isCodeErrorDisplayed = false;
  bool _isNomeJogadorErrorDisplayed = false;
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    checkIfUserIsLogged();
  }

  checkIfUserIsLogged() async {
    setState(() async {
      isLogged = await _bloc.getUsuarioLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Jogar",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    (isLogged)
                        ? "Insira o código do quiz para poder jogar."
                        : "Insira seu nome e o código do quiz para poder jogar.",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Form(
                    key: _bloc.formKey,
                    child: Column(
                      children: [
                        Visibility(
                          visible: !isLogged,
                          child: TextFormField(
                            controller: _bloc.nomeJogadorController,
                            style: Theme.of(context).textTheme.bodyText1,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              labelText: "Nome",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: TextFormField(
                            controller: _bloc.codeController,
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              labelText: "Código",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (_bloc.codeController.text.isEmpty) {
                                _isCodeErrorDisplayed = true;
                                return "Campo de código vazio!";
                              }
                              _isCodeErrorDisplayed = false;
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: QuizyzAppButton(
                            title: "Jogar",
                            onTap: () async {
                              if (_bloc.formKey.currentState.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GamePage(title: "Nome no quiz"),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

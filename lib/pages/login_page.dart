import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/bloc/login_bloc.dart';
import 'package:quizyz/components/purple_button.dart';
import 'package:quizyz/components/quizzy_app_button.dart';
import 'package:quizyz/pages/controller_page.dart';
import 'package:quizyz/pages/home/quizzes/quizzes_page.dart';
import 'package:quizyz/pages/signup_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/custom_shared_preferences.dart';
import 'package:quizyz/utils/helpers/helpers.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc = LoginBloc();
  bool _isSenhaErrorDisplayed = false;
  bool _isEmailErrorDisplayed = false;
  bool _showSenha = true;

  @override
  void initState() {
    super.initState();
    _loginStream();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _doLogin() async {
    if (Helpers.validateEmail(_bloc.emailController.text) &&
        Helpers.validatePassword(_bloc.senhaController.text)) {
      await _bloc.doLogin();
    }
  }

  _loginStream() async {
    _bloc.loginStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => ControllerPage(),
            ),
            (route) => false,
          );
          break;
        case Status.LOADING:
          ManagerDialogs.showLoadingDialog(context);
          break;
        case Status.ERROR:
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Quizyz",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: Form(
                    key: _bloc.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _bloc.emailController,
                          style: Theme.of(context).textTheme.bodyText1,
                          cursorColor: whiteColor,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                          validator: (value) {
                            if (_bloc.emailController.text.isEmpty) {
                              _isEmailErrorDisplayed = true;
                              return "Campo de e-mail vazio!";
                            }
                            if (!Helpers.validateEmail(
                                _bloc.emailController.text)) {
                              _isEmailErrorDisplayed = true;
                              return "E-mail inválido!";
                            }
                            _isEmailErrorDisplayed = false;
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: TextFormField(
                            controller: _bloc.senhaController,
                            obscureText: _showSenha,
                            style: Theme.of(context).textTheme.bodyText1,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showSenha = !_showSenha;
                                  });
                                },
                                child: IconTheme(
                                  data: Theme.of(context).iconTheme.copyWith(
                                        color: greyColor,
                                      ),
                                  child: Icon(
                                    _showSenha == true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (_bloc.senhaController.text.isEmpty) {
                                _isSenhaErrorDisplayed = true;
                                return "Campo de senha vazio!";
                              }
                              if (!Helpers.validatePassword(
                                  _bloc.senhaController.text)) {
                                _isSenhaErrorDisplayed = true;
                                return "Senha inválida!";
                              }
                              _isSenhaErrorDisplayed = false;
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 128),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Eu vim jogar!",
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: greyColor,
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: QuizyzAppButton(
                            title: "Login",
                            onTap: () async {
                              if (_bloc.formKey.currentState.validate()) {
                                await _doLogin();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: PurpleButton(
                            titulo: "Cadastro",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/bloc/sign_up_bloc.dart';

import 'package:quizyz/components/quizzy_app_button.dart';
import 'package:quizyz/pages/login_page.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/helpers/helpers.dart';
import 'package:quizyz/utils/helpers/manage_dialogs.dart';
import 'package:quizyz/utils/style/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpBloc _bloc = SignUpBloc();
  bool _exibirSenha = true;

  bool _isNameErrorDisplayed = false;
  bool _isEmailErrorDisplayed = false;
  bool _isPasswordErrorDisplayed = false;

  @override
  void initState() {
    super.initState();
    _signUpStream();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _signUpStream() {
    _bloc.signUpStream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => LoginPage()),
              (r) => false);

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
          "Cadastro",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 60, right: 24.0, left: 24.0),
                child: Form(
                  key: _bloc.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
                          controller: _bloc.nameController,
                          validator: (value) {
                            if (!Helpers.validateName(
                                _bloc.nameController.text)) {
                              _isNameErrorDisplayed = true;
                              return "Campo de nome vazio";
                            }

                            return null;
                          },
                          cursorColor: whiteColor,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Nome",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
                          controller: _bloc.emailController,
                          validator: (value) {
                            if (_bloc.emailController.text.isEmpty) {
                              _isEmailErrorDisplayed = true;
                              return "Campo de e-mail vazio";
                            }

                            if (!Helpers.validateEmail(
                                _bloc.emailController.text)) {
                              _isEmailErrorDisplayed = true;
                              return "E-mail invalido!";
                            }

                            return null;
                          },
                          cursorColor: whiteColor,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
                          controller: _bloc.senhaController,
                          cursorColor: whiteColor,
                          validator: (value) {
                            if (!Helpers.validatePassword(
                                _bloc.senhaController.text)) {
                              _isPasswordErrorDisplayed = true;
                              return "Senha invalida";
                            }

                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: _exibirSenha,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() {
                                _exibirSenha = !_exibirSenha;
                              }),
                              child: Icon(
                                _exibirSenha == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
                          controller: _bloc.confirmSenhaController,
                          cursorColor: whiteColor,
                          validator: (value) {
                            if (_bloc.senhaController.text !=
                                _bloc.confirmSenhaController.text) {
                              return "Senhas diferentes";
                            } else if (_bloc
                                .confirmSenhaController.text.isEmpty) {
                              return "Campo confirmar senha vazio";
                            }

                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: _exibirSenha,
                          decoration: InputDecoration(
                            labelText: "Confirma senha",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() {
                                _exibirSenha = !_exibirSenha;
                              }),
                              child: Icon(
                                _exibirSenha == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
                  child: QuizyzAppButton(
                      title: "Cadastro",
                      onTap: () async {
                        if (_bloc.formKey.currentState.validate()) {
                          await _bloc.doSignUp();
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:quizyz/components/quizyz_app_button.dart';
import 'package:quizyz/utils/style/colors.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //FormKey para validação
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Controllers de edição de texto
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmSenhaController = TextEditingController();

  //Controle de exibicao de senha
  bool _exibirSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cadastro",
          style: baseTheme.textTheme.headline1.copyWith(color: accentColor),
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
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
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
                          cursorColor: whiteColor,
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
                          cursorColor: whiteColor,
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
                  child: QuizyzAppButton(onTap: () => null),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

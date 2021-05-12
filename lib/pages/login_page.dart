import 'package:flutter/material.dart';
import 'package:quizyz/components/quizzy_app_button.dart';
import 'package:quizyz/utils/style/colors.dart';
import 'package:quizyz/utils/style/text_size.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _showSenha = false;
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
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          style: Theme.of(context).textTheme.bodyText1,
                          cursorColor: whiteColor,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: TextFormField(
                            controller: _senhaController,
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
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: purpleColor),
                              ),
                              child: Center(
                                child: Text(
                                  "Cadastro",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        color: purpleColor,
                                        fontSize: TextSize.large,
                                      ),
                                ),
                              ),
                            ),
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

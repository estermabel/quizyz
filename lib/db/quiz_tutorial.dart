import 'package:quizyz/model/Pergunta.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/Resposta.dart';
import 'package:quizyz/model/User.dart';

class QuizTutorial {
  static Quiz quiz = Quiz(
    id: 0,
    criador: User(
      id: 0,
      nome: "Quizyz",
      email: "quizyz@contato.com",
      senha: "quizyz1234",
    ),
    titulo: "Tutorial",
    perguntas: [
      Pergunta(
        id: 0,
        titulo: "Quantos continentes tem no mundo?",
        respostas: [
          Resposta(id: 0, titulo: "4", isCerta: false),
          Resposta(id: 1, titulo: "7", isCerta: false),
          Resposta(id: 2, titulo: "3", isCerta: false),
          Resposta(id: 3, titulo: "6", isCerta: true),
        ],
      ),
      Pergunta(
        id: 1,
        titulo: "Quantos países tem no mundo?",
        respostas: [
          Resposta(id: 0, titulo: "99", isCerta: false),
          Resposta(id: 1, titulo: "100", isCerta: false),
          Resposta(id: 2, titulo: "193", isCerta: true),
          Resposta(id: 3, titulo: "120", isCerta: false),
        ],
      ),
    ],
  );
}

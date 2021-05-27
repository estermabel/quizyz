import 'package:quizyz/db/config/data_base_helper.dart';
import 'package:quizyz/model/ScoreQuiz.dart';

class ScoreDb {
  final db = DatabaseHelper.instance;

  Future<List<ScoreQuiz>> getScoreQuizzes() async {
    final List<ScoreQuiz> _quizzes = await db.getQuizzes();
    return _quizzes;
  }

  Future addQuizToDB({ScoreQuiz quiz}) async {
    await db.insert(quiz);
  }
}

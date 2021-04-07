import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:m_whm/sqlite/db_helper.dart';

enum QuestionsChoice { ya, tidak, belum_di_set }

class Questions {
  List<QuestionsChoice> _answer = [QuestionsChoice.belum_di_set];

  QuestionsChoice _currentAnswer = QuestionsChoice.belum_di_set;

  int currentQuestions = 1;

  int numberForm = 1;

  var dbHelper = DBHelper();

  void clearQuestions() {
    _answer = [QuestionsChoice.belum_di_set];

    _currentAnswer = QuestionsChoice.belum_di_set;

    currentQuestions = 1;

    numberForm = 1;
  }

  List<QuestionsChoice> getAnswer() {
    return _answer;
  }

  setAnswer(value) {
    _answer.replaceRange(currentQuestions - 1, currentQuestions, [value]);
    _currentAnswer = value;
  }

  QuestionsChoice getCurrentAnswer() {
    return _currentAnswer;
  }

  QuestionsChoice convertToQuestionChoice(value) {
    if (value == "Ya") {
      return QuestionsChoice.ya;
    } else if (value == "Tidak") {
      return QuestionsChoice.tidak;
    } else {
      return QuestionsChoice.belum_di_set;
    }
  }

  int getCurrentQuestions() {
    return currentQuestions;
  }

  bool isLast(questionList) {
    if (currentQuestions == questionList.length) {
      insertToDb(questionList, _answer);
      return true;
    } else
      return false;
  }

  void insertToDb(question, answer) async {
    final DateTime now = DateTime.now();

    for (var i = 0; i < answer.length; i++) {
      Map<String, dynamic> row = {
        "name": "Weekly Health Monitoring",
        "question": question[i]['question'],
        'answer': answer[i] == QuestionsChoice.ya ? "YA" : "TIDAK",
        'date': now.toString(),
        'user': FirebaseAuth.instance.currentUser.email.toString()
      };

      await dbHelper.save(row);
    }
  }

  void nextQuestions() {
    currentQuestions++;
    _currentAnswer = QuestionsChoice.belum_di_set;
    _answer.add(QuestionsChoice.belum_di_set);
    numberForm = 1;
  }
}

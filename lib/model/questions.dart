enum QuestionsChoice { ya, tidak, belum_di_set }

class Questions {
  List<QuestionsChoice> _answer = [QuestionsChoice.belum_di_set];

  QuestionsChoice _currentAnswer = QuestionsChoice.belum_di_set;

  int currentQuestions = 1;

  int numberForm = 1;

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
    if (currentQuestions == questionList.length)
      return true;
    else
      return false;
  }

  void nextQuestions() {
    print(currentQuestions);
    currentQuestions++;
    _currentAnswer = QuestionsChoice.belum_di_set;
    _answer.add(QuestionsChoice.belum_di_set);
    numberForm = 1;
  }
}

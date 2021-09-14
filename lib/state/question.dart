import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_whm/constants/api_path.dart';
import 'package:m_whm/services/network.dart';
import 'package:m_whm/db/db_questioner.dart';

enum QuestionsChoice { ya, tidak, belum_di_set }

class QuestionData extends ChangeNotifier {
  String title = '';

  List<Map<String, String>> form = [{}];

  dynamic quesionerLists;
  dynamic quesionerList;

  List<Map<String, dynamic>> answerList = [
    {
      'answer': QuestionsChoice.belum_di_set,
      'additional': [],
    }
  ];

  QuestionsChoice currentAnswer = QuestionsChoice.belum_di_set;

  int currentQuestions = 1;

  int numberForm = 1;

  var dBQuestioner = DBQuestioner();

  fetchQuestion() async {
    var data = await NetworkHelper().getData(api_path + 'questions');

    quesionerLists = data;
  }

  setQuesionerList(val) {
    quesionerList = val;
  }

  void clearQuestions() {
    answerList = [
      {
        'answer': QuestionsChoice.belum_di_set,
        'additional': [],
      }
    ];

    currentAnswer = QuestionsChoice.belum_di_set;

    currentQuestions = 1;
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

  bool isLast(questionList) {
    if (currentQuestions == questionList.length) {
      setAdditional();
      return true;
    } else
      return false;
  }

  bool next() {
    if (!isLast(quesionerList ?? null)) {
      return true;
    } else {
      return false;
    }
  }

  void nextQuestions() async {
    setAdditional();

    currentQuestions++;

    currentAnswer = QuestionsChoice.belum_di_set;

    answerList.add({
      'answer': QuestionsChoice.belum_di_set,
      'additional': [],
    });

    numberForm = 1;
    form = [{}];
    notifyListeners();
  }

  void insertToDb() async {
    final DateTime now = DateTime.now();

    // Map<String, dynamic> row = {
    //   "name": title,
    //   "question": jsonEncode(quesionerList.map((e) => e['question']).toList()),
    //   'answer': jsonEncode(answerList
    //       .map((e) => e['answer'] == QuestionsChoice.ya ? "YA" : "TIDAK")
    //       .toList()),
    //   'additional': jsonEncode(answerList.map((e) => e['additional']).toList()),
    //   'show':
    //       jsonEncode(quesionerList.map((e) => e['show_detail_when']).toList()),
    //   'date': now.toString(),
    //   'user': FirebaseAuth.instance.currentUser.email.toString()
    // };

    Map<String, dynamic> rowRaw = {
      "name": title,
      "question": quesionerList.map((e) => e['question']).toList(),
      'answer': answerList
          .map((e) => e['answer'] == QuestionsChoice.ya ? "YA" : "TIDAK")
          .toList(),
      'additional': jsonEncode(answerList.map((e) => e['additional']).toList()),
      'show': quesionerList.map((e) => e['show_detail_when']).toList(),
      'date': now.toString(),
      'user': FirebaseAuth.instance.currentUser.email.toString()
    };

    await NetworkHelper().postData(
      'https://weekly-health-monitoring-default-rtdb.firebaseio.com/questions.json',
      rowRaw,
    );

    // CollectionReference quesioner =
    //     FirebaseFirestore.instance.collection('quesioner');

    // quesioner
    //     .add(row)
    //     .then((value) {})
    //     .catchError((error) => print("Failed to add user: $error"));

    // dBQuestioner.save(row);

    notifyListeners();
  }

  void setAdditional() {
    answerList.replaceRange(currentQuestions - 1, currentQuestions, [
      {'answer': currentAnswer, 'additional': this.form}
    ]);

    // notifyListeners();
  }

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void minusNumberForm(int index) {
    numberForm--;
    form.removeAt(index);

    notifyListeners();
  }

  void clearForm(index) {
    form[index ?? 0] = {};
    numberForm = 1;
    // notifyListeners();
  }

  void setForm(String value, index, key) {
    form[index][key] = value;

    notifyListeners();
  }

  void addForm() {
    form.add({});
    numberForm++;

    notifyListeners();
  }

  void setNumberForm(int value) {
    currentQuestions = value;
    notifyListeners();
  }

  void setCurrentQuestions(int value) {
    currentQuestions = value;
    notifyListeners();
  }
}

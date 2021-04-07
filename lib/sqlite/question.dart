class QuestionModelSql {
  int id;
  String name;
  String question;
  String answer;
  String date;
  String user;

  QuestionModelSql(
    this.id,
    this.name,
    this.question,
    this.answer,
    this.date,
    this.user,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'question': question,
      'answer': answer,
      'user': user,
      'date': date,
    };
    return map;
  }

  QuestionModelSql.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    question = map['question'];
    answer = map['answer'];
    user = map['user'];
    date = map['date'];
  }
}

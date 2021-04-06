class QuestionModelSql {
  int id;
  String name;
  String question;
  String answer;
  String date;

  QuestionModelSql(this.id, this.name, this.question, answer, date);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'question': question,
      'answer': answer,
      'date': date,
    };
    return map;
  }

  QuestionModelSql.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    question = map['question'];
    answer = map['answer'];
    date = map['date'];
  }
}

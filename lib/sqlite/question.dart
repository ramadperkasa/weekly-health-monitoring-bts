class QuestionSql {
  int id;
  String name;

  QuestionSql(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  QuestionSql.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}

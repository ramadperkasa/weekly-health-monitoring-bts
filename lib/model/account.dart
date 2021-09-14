class AccountModel {
  int id;
  String name;
  String position;
  String nik;
  String email;
  String phoneNumber;
  String gender;

  AccountModel({
    this.id,
    this.name,
    this.position,
    this.nik,
    this.email,
    this.phoneNumber,
    this.gender,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    nik = json['nik'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['nik'] = this.nik;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    return data;
  }
}

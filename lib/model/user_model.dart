class UserModel {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? adress;
  String? details;
  String? token;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.adress,
      required this.details,
      required this.token,
      });

  UserModel.fromJson({required Map<String, dynamic> map}) {
    id = map['id'];
    fullName = map['fullName'];
    phoneNumber = map['phoneNumber'];
    adress = map['adress'];
    details = map['details'];
    token = map['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "adress": adress,
      "details": details,
      "token": token,
    };
  }
}

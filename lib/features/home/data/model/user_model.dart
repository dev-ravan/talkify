class UserModel {
  String uid;
  String name;
  String userName;
  String email;
  String password;
  String photo;

  UserModel({
    required this.uid,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "userName": userName,
        "email": email,
        "password": password,
        "photo": photo,
      };
}

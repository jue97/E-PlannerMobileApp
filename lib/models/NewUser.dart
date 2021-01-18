//import 'package:cloud_firestore/cloud_firestore.dart';

class NewUser {
  final String id;
  final String name;
  final String email;
  final String phoneNum;
  final String userType;
  final String password;
  final String verified;

  NewUser(
      {this.id,
      this.name,
      this.email,
      this.phoneNum,
      this.userType,
      this.password,
      this.verified});

  NewUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phoneNum = data['phoneNum'],
        userType = data['userType'],
        password = data['password'],
        verified = data['verified'];

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'userName': name,
      'email': email,
      'phoneNum': phoneNum,
      'password': password,
      'userType' : userType,
      'verified' : verified
    };
  }

  static fromSnapshot(eventSnapshot) {}
}

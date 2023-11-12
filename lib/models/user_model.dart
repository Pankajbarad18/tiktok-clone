import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String profilePhoto;
  String uid;

  User(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.uid});

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "profilePhoto": profilePhoto, "uid": uid};

  static User fromsnap(DocumentSnapshot snapshot) {
    var snap = snapshot as Map<String, dynamic>;
    return User(
        name: snap['name'],
        email: snap['email'],
        profilePhoto: snap['profilePhoto'],
        uid: snap['uid']);
  }
}

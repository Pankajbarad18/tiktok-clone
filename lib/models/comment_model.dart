import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Comment extends GetxController {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id
      };

  static Comment fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Comment(
        username: snap['username'],
        comment: snap['comment'],
        datePublished: snap['datePublished'],
        likes: snap['likes'],
        profilePhoto: snap['profilePhoto'],
        uid: snap['uid'],
        id: snap['id']);
  }
}

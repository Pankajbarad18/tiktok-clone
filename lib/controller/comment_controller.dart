import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(fireStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> commentList = [];
      for (var element in query.docs) {
        commentList.add(Comment.fromSnap(element));
      }
      return commentList;
    }));
  }

  postComment(String commentText) async {
    try {
      DocumentSnapshot userDocs = await fireStore
          .collection('users')
          .doc(authController.user.uid)
          .get();

      var allDocs = await fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .get();

      int len = allDocs.docs.length;

      Comment comment = Comment(
          username: (userDocs.data()! as Map<String, dynamic>)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto:
              (userDocs.data()! as Map<String, dynamic>)['profilePhoto'],
          uid: authController.user.uid,
          id: 'Comment $len');
      await fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc('Comment $len')
          .set(comment.toJson());
      DocumentSnapshot docs =
          await fireStore.collection('videos').doc(_postId).get();
      await fireStore.collection('videos').doc(_postId).update({
        'commentCount':
            (docs.data()! as Map<String, dynamic>)['commentCount'] + 1,
      });
    } catch (e) {
      Get.snackbar('Error in Commenting', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    print(id);
    DocumentSnapshot doc = await fireStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}

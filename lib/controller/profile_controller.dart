import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  getUpdateId(String id) {
    _uid.value = id;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await fireStore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDocs =
        await fireStore.collection('users').doc(_uid.value).get();
    final userData = userDocs.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int following = 0;
    int followers = 0;
    int likes = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followerDocs = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDocs = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDocs.docs.length;
    following = followingDocs.docs.length;

    fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers,
      'following': following,
      'likes': likes,
      'name': name,
      'profilePhoto': profilePhoto,
      'isFollowing': isFollowing,
      'thumbnails': thumbnails
    };
    update();
  }

  followUser() async {
    var docs = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    if (!docs.exists) {
      await fireStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await fireStore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
          'followers',
          _user.value.update(
            'followers',
            (value) => (int.parse(value) + 1).toString(),
          ));
    } else {
      await fireStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await fireStore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
          'followers',
          _user.value.update(
            'followers',
            (value) => (int.parse(value) - 1).toString(),
          ));
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}

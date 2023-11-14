import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        fireStore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retval = [];
      for (var elements in query.docs) {
        retval.add(Video.fromSnap(elements));
      }
      return retval;
    }));
  }

  likevideo(String id) async {
    DocumentSnapshot documentSnapshot =
        await fireStore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((documentSnapshot.data()! as dynamic)['likes'].contains(uid)) {
      await fireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await fireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}

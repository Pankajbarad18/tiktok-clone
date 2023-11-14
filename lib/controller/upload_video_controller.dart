import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';
import 'package:video_compress_plus/video_compress_plus.dart';

class VideoUploadController extends GetxController {
  _compressVideo(String videoPath) async {
    final videoCompress = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return videoCompress!.file;
  }

  _uploadVideoUrl(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImageUrl(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _getthumbnail(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getthumbnail(String videoPath) async {
    final t = await VideoCompress.getFileThumbnail(videoPath);
    return t;
  }

  uploadVideo(String videoPath, String caption, String songName) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDocs =
          await fireStore.collection('users').doc(uid).get();
      var allDocs = await fireStore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoUrl('Video $len', videoPath);
      String thumbnail = await _uploadImageUrl('Video $len', videoPath);
      Video video = Video(
          username: (userDocs.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDocs.data()! as Map<String, dynamic>)['profilePhoto']);
      await fireStore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}

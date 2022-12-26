import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../../routes/app_pages.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();

  final storage = FirebaseStorage.instance;

  Future<void> updateProfile(String uid) async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      try {
        Map<String, Object> data = {
          "name": nameController.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref("$uid/profile_picture.$ext").putFile(file);
          String urlImage =
              await storage.ref("$uid/profile_picture.$ext").getDownloadURL();

          data.addAll({"profile_picture": urlImage});
        }
        isLoading.value = true;
        await firestore.collection('pegawai').doc(uid).update(data);
        image = null;
        Get.snackbar('Berhasil!', 'Anda berhasil update profile');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Anda tidak dapat update profile');
      } finally {
        isLoading.value = false;
      }
    }
  }

  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    update();
  }

  void deleteProfilrPicture(String uid) async {
    try {
      await firestore.collection("pegawai").doc(uid).update({
        "profile_picture": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar('Berhasil!', 'Anda berhasil menghapus photo profile');
    } catch (e) {
      Get.snackbar(
          'Terjadi Kesalahan', 'Anda tidak dapat menghapus photo profile');
    } finally {
      update();
    }
  }
}

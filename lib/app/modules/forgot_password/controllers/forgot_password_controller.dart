import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailController.text);
        Get.snackbar('Berhasil!',
            'Email berhasil terkirim, kami telah mengirimkan email untuk me-reset password anda');
        Get.back();
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan',
            'Tidak dapat mengirim email, mohon coba lagi nanti');
      } finally {
        isLoading.value = false;
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  var isPasswordHide = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordController.text == '123456') {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: 'Peringatan !',
                middleText:
                    'Email yang anda gunakan belum terverifikasi, silahkan verifikasi email anda',
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await credential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar('Berhasil',
                              'Kami telah mengirim email verifikasi ke akun anda, silahkan cek email anda');
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar('Terjadi kesalahan',
                              'Tidak dapat mengirim email verifikasi, silahkan hubungi administrator');
                        }
                      },
                      child: Text('Kirim ulang'))
                ]);
          }
        }

        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar('Terjadi kesalahan', 'Email belum terdaftar');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              'Terjadi kesalahan', 'Password salah, silahkan coba lagi');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Terjadi kesalahan', 'Anda tidak dapat login');
      }
    } else {
      Get.snackbar(
          'Terjadi kesalahan', 'Email dan Password tidak boleh kosong');
    }
  }
}

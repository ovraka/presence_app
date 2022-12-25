import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  var isPasswordHide = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passwordController.text.isNotEmpty) {
      try {
        if (passwordController.text != '123456') {
          await auth.currentUser!.updatePassword(passwordController.text);

          String email = auth.currentUser!.email!;

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: passwordController.text);

          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Terjadi kesalahan',
              'Password baru harus di ubah, jangan menggunakan password default kembali');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi kesalahan", "Password minimal 6 karakter");
        }
      } catch (e) {
        Get.snackbar('Terjadi kesalahan',
            'Anda tidak dapat mengganti password, silahkan hubungi Administrator');
      }
    } else {
      Get.snackbar('Terjadi kesalahan', 'Password baru tidak boleh kosong');
    }
  }
}

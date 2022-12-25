import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  var isCurrentPasswordHide = true.obs;
  var isNewPassworddHide = true.obs;
  var isConfirmNewPasswordHide = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        isLoading.value = true;
        try {
          String emailCurrentUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailCurrentUser,
              password: currentPasswordController.text);

          await auth.currentUser!.updatePassword(newPasswordController.text);

          Get.back();
          Get.snackbar('Berhasil!', 'Anda berhasil mengganti pasword');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Get.snackbar('Terjadi Kesalahan',
                'Current password salah, masukkan dengan benar');
          } else {
            Get.snackbar('Terjadi Kesalahan', "${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar('Terjadi Kesalahan', 'Tidak dapat mengganti password');
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar('Terjadi Kesalahan', 'Confirm password harus sama');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Password tidak boleh kosong');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordDialogController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool isLoadingDialog = false.obs;

  CollectionReference pegawai =
      FirebaseFirestore.instance.collection('pegawai');

  Future<void> proccessAddPegawai() async {
    if (passwordDialogController.text.isNotEmpty) {
      isLoadingDialog.value = true;
      try {
        //Ambil email admin dari auth
        String adminEmail = auth.currentUser!.email!;

        //Validasi login admin
        final adminCredential = await auth.signInWithEmailAndPassword(
            email: adminEmail, password: passwordDialogController.text);

        //Validasi tambah data pegawai
        final credential = await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: '123456',
        );

        if (credential.user != null) {
          String uid = credential.user!.uid;
          await fireStore.collection('pegawai').doc(uid).set({
            "nip": nipController.text,
            "name": nameController.text,
            "email": emailController.text,
            "role": "karyawan",
            "uid": uid,
            "create_at": DateTime.now().toIso8601String(),
          });

          await credential.user!.sendEmailVerification();

          nameController.clear();
          nipController.clear();
          emailController.clear();

          await auth.signOut();

          final adminCredential = await auth.signInWithEmailAndPassword(
              email: adminEmail, password: passwordDialogController.text);

          Get.back(); //Close dialog
          Get.back(); //Back to home

          Get.snackbar("Berhasil!", "Berhasil menambahkan pegawai");
        }
        isLoadingDialog.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingDialog.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi kesalahan", "Password minimal 6 karakter");
        } else if (e.code == 'emailalready-in-use') {
          Get.snackbar("Terjadi kesalahan", "Email telah digunakan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi kesalahan", "Password salah, masukkan dengan benar");
        } else {
          isLoadingDialog.value = false;
          Get.snackbar("Terjadi kesalahan", "${e.code}");
        }
      } catch (e) {
        Get.snackbar("Terjadi kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", "Password tidak boleh kosong");
    }
  }

  Future<void> addPegawai() async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: 'Konfirmasi Admin',
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text('Masukkan password anda'),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordDialogController,
                autocorrect: false,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              )
            ],
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: const Text("Batal")),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (isLoadingDialog.isFalse) {
                  await proccessAddPegawai();
                }
                isLoading.value = false;
              },
              child:
                  Text(isLoadingDialog.isFalse ? 'Konfirmasi' : 'Loading...')))
        ],
      );
    } else {
      Get.snackbar("Terjadi kesalahan", "NIP, Nama, dan Email harus diisi");
    }
  }
}

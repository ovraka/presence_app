import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection('pegawai').doc(uid).snapshots();
  }

  void logout() async {
    if (isLoading.isFalse) {
      Get.defaultDialog(
        title: 'Logout',
        content: const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Apakah anda yakin ingin logout ?'),
        ),
        actions: [
          OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: const Text('Batal')),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (isLoading.isFalse) {
                  await auth.signOut();
                  Get.offAllNamed(Routes.LOG_IN);
                }
                isLoading.value = false;
              },
              child: Text(isLoading.isFalse ? 'Oke' : 'Loading...')))
        ],
      );
    }
  }
}

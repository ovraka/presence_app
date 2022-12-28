import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MorePresensiController extends GetxController {
  DateTime? startDate;
  DateTime endDate = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> historyPresence() async {
    String uid = auth.currentUser!.uid;

    if (startDate == null) {
      //Mendapatkan semua absensi sampai hari ini
      return await fireStore
          .collection('pegawai')
          .doc(uid)
          .collection('presence')
          .where('date', isLessThan: endDate.toIso8601String())
          .orderBy('date', descending: true)
          .get();
    } else {
      //Range dari tanggal mulai yang dipilih
      return await fireStore
          .collection('pegawai')
          .doc(uid)
          .collection('presence')
          .where('date', isGreaterThan: startDate!.toIso8601String())
          .where('date',
              isLessThan:
                  endDate.add(const Duration(days: 1)).toIso8601String())
          .orderBy('date', descending: true)
          .get();
    }
  }

  void pickerDate(DateTime pickStartDate, DateTime pickEndDate) {
    startDate = pickStartDate;
    endDate = pickEndDate;
    update();
    Get.back();
  }
}

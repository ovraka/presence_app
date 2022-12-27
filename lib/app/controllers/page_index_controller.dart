import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      case 1:
        Map<String, dynamic> responseData = await determinePosition();
        if (responseData["error"] != true) {
          Position position = responseData["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].postalCode}";
          await updatePosition(position, address);

          //Cek distance position
          double distance = Geolocator.distanceBetween(
              -6.165911, 106.7786348, position.latitude, position.longitude);

          //Presensi
          await presensi(position, address, distance);
        } else {
          Get.snackbar("Terjadi Kesalahan", "${responseData["message"]}");
        }

        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresence =
        await firestore.collection("pegawai").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapshootPresence =
        await colPresence.get();

    DateTime now = DateTime.now();
    String docId = DateFormat.yMd().format(now).replaceAll("/", "-");
    String status = "Di Luar Area Office";
    if (distance <= 200) {
      //Di dalam area jangkauan absensi
      status = "Di Dalam Area Office";
    }

    if (snapshootPresence.docs.isEmpty) {
      //belum absen sama sekali

      await Get.defaultDialog(
          title: "Perhatian!",
          content: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Apakah anda yakin ingin absen MASUK sekarang ?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          )),
                        )),
                    TextButton(
                        onPressed: () async {
                          await colPresence.doc(docId).set({
                            "date": now.toIso8601String(),
                            "start_day": {
                              "date": now.toIso8601String(),
                              "lat": position.latitude,
                              "long": position.longitude,
                              "address": address,
                              "status": status,
                              "distance": distance,
                            }
                          });
                          Get.back();
                          Get.snackbar("Berhasil!", "Anda telah absen masuk");
                        },
                        child: Text(
                          "Ok",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                        )),
                  ],
                ),
              ],
            ),
          ));
    } else {
      //Cek absen masuk dan keluar hari ini sudah/belum
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresence.doc(docId).get();

      if (todayDoc.exists == true) {
        Map<String, dynamic>? dataPresenceToday = await todayDoc.data();
        if (dataPresenceToday?["end_day"] != null) {
          Get.snackbar('Peringatan!', 'Anda telah absen hari ini');
        } else {
          await Get.defaultDialog(
              title: "Perhatian!",
              content: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Apakah anda yakin ingin absen KELUAR sekarang ?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                            )),
                        TextButton(
                            onPressed: () async {
                              await colPresence.doc(docId).update({
                                "end_day": {
                                  "date": now.toIso8601String(),
                                  "lat": position.latitude,
                                  "long": position.longitude,
                                  "address": address,
                                  "status": status,
                                  "distance": distance,
                                }
                              });
                              Get.back();
                              Get.snackbar(
                                  "Berhasil!", "Anda telah absen keluar");
                            },
                            child: Text(
                              "Ok",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                            )),
                      ],
                    ),
                  ],
                ),
              ));
        }
      } else {
        await Get.defaultDialog(
            title: "Perhatian!",
            content: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Apakah anda yakin ingin absen MASUK sekarang ?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            )),
                          )),
                      TextButton(
                          onPressed: () async {
                            await colPresence.doc(docId).set({
                              "date": now.toIso8601String(),
                              "start_day": {
                                "date": now.toIso8601String(),
                                "lat": position.latitude,
                                "long": position.longitude,
                                "address": address,
                                "status": status,
                                "distance": distance,
                              }
                            });
                            Get.back();
                            Get.snackbar("Berhasil!", "Anda telah absen masuk");
                          },
                          child: Text(
                            "Ok",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          )),
                    ],
                  ),
                ],
              ),
            ));
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;

    await firestore.collection("pegawai").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {"message": "Layanan lokasi dinonaktifkan.", "error": true};
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {"message": "Izin lokasi ditolak", "error": true};
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {"message": "Izin lokasi ditolak secara permanen", "error": true};
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Berhasil mendapatkan lokasi anda",
      "error": false
    };
  }
}

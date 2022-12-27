import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:presence_app/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageController = Get.find<PageIndexController>();
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
        ),
        // ignore: prefer_const_constructors
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;
                String defaultImage =
                    "https://ui-avatars.com/api/?name=${user['name']}&&background=f0e9e9&&size=200";
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 75,
                            height: 75,
                            color: Colors.grey[200],
                            child: Image.network(
                                user["profile_picture"] ?? defaultImage,
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            Container(
                              width: 250,
                              child: Text(
                                user["address"] != null
                                    ? "${user["address"]}"
                                    : "Lokasi belum diatur",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user['job_title']}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${user['nip']}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${user['name']}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Masuk",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              ),
                              Text(
                                "-",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            color: Colors.grey,
                            height: 40,
                          ),
                          Column(
                            children: [
                              Text(
                                "Keluar",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              ),
                              Text(
                                "-",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last 5 days",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.MORE_PRESENSI);
                          },
                          child: Text(
                            "See more",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_PRESENSI);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Start Day",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black)),
                                        ),
                                        Text(
                                          "${DateFormat.yMMMEd().format(DateTime.now())}",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${DateFormat.jms().format(DateTime.now())}",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "End Day",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                    Text(
                                      "${DateFormat.jms().format(DateTime.now())}",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "Tidak dapat memuat data",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                );
              }
            }),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.fingerprint, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageController.pageIndex.value,
          onTap: (int i) => pageController.changePage(i),
        ));
  }
}

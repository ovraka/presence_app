import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

import '../../../controllers/page_index_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageController = Get.find<PageIndexController>();
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snap.hasData) {
                Map<String, dynamic> user = snap.data!.data()!;
                String defaultImage =
                    "https://ui-avatars.com/api/?name=${user['name']}&&background=f0e9e9&&size=200";
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              user["profile_picture"] != null
                                  ? user["profile_picture"] != ""
                                      ? user["profile_picture"]
                                      : defaultImage
                                  : defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user['name'].toString().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Text(
                      "${user['email']}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                      },
                      leading: Icon(Icons.person),
                      title: Text('Update Profile'),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.UPDATE_PASSWORD);
                      },
                      leading: Icon(Icons.vpn_key),
                      title: Text('Update Password'),
                    ),
                    if (user["role"] == "admin")
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.SIGN_UP);
                        },
                        leading: Icon(Icons.person_add),
                        title: Text('Tambah Pegawai'),
                      ),
                    ListTile(
                      onTap: () => controller.logout(),
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text('Tidak dapat memuat data '),
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

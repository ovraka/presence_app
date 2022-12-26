import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/theme/colors.dart';
import '../../../data/theme/custom_widget.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipController.text = user['nip'];
    controller.nameController.text = user['name'];
    controller.emailController.text = user['email'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                inputText(
                    readOnly: true,
                    controller: controller.nipController,
                    hintText: 'NIP',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: true,
                    controller: controller.emailController,
                    hintText: 'Email',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.nameController,
                    hintText: 'Nama',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Profile Picture",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: bgForm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<UpdateProfileController>(
                          builder: (controller) {
                        if (controller.image != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.file(
                                File(controller.image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          if (user['profile_picture'] != null) {
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      user['profile_picture'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller
                                            .deleteProfilrPicture(user["uid"]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.red[600],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Delete",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          const Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            );
                          } else {
                            return Text(
                              "No file choosen",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: tagline)),
                            );
                          }
                        }
                      }),
                      SizedBox(
                          child: ElevatedButton(
                        onPressed: () {
                          controller.pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 1, color: tagline)),
                        child: Text(
                          "Choose File",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: tagline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => gradientButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.updateProfile(user['uid']);
                      }
                    },
                    buttonText: controller.isLoading.isFalse
                        ? 'Update Profile'
                        : 'Loading...'))
              ],
            ),
          )),
        ),
      ),
    );
  }
}

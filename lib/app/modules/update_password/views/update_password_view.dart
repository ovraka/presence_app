import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/custom_widget.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdatePasswordView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              inputPassword(
                  controller: controller.currentPasswordController,
                  obscureText: controller.isCurrentPasswordHide,
                  onPressed: () {
                    controller.isCurrentPasswordHide.toggle();
                  },
                  isPasswordHide: controller.isCurrentPasswordHide,
                  hintText: ' Current password'),
              const SizedBox(
                height: 20,
              ),
              inputPassword(
                  controller: controller.newPasswordController,
                  obscureText: controller.isNewPassworddHide,
                  onPressed: () {
                    controller.isNewPassworddHide.toggle();
                  },
                  isPasswordHide: controller.isNewPassworddHide,
                  hintText: 'New password'),
              const SizedBox(
                height: 20,
              ),
              inputPassword(
                  controller: controller.confirmNewPasswordController,
                  obscureText: controller.isConfirmNewPasswordHide,
                  onPressed: () {
                    controller.isConfirmNewPasswordHide.toggle();
                  },
                  isPasswordHide: controller.isConfirmNewPasswordHide,
                  hintText: 'Confirm password'),
              const SizedBox(
                height: 20,
              ),
              Obx(() => gradientButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      controller.updatePassword();
                    }
                  },
                  buttonText: (controller.isLoading.isFalse
                      ? 'CHANGE PASSWORD'
                      : 'LOADING...'))),
            ]),
          )),
        ),
      ),
    );
  }
}

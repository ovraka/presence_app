import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/data/theme/colors.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../../../data/theme/custom_widget.dart';
import '../controllers/log_in_controller.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
                    readOnly: false,
                    controller: controller.emailController,
                    hintText: 'Email',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                inputPassword(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHide,
                    onPressed: () {
                      controller.isPasswordHide.toggle();
                    },
                    isPasswordHide: controller.isPasswordHide,
                    hintText: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => gradientButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.login();
                      }
                    },
                    buttonText: (controller.isLoading.isFalse
                        ? 'LOG IN'
                        : 'LOADING...'))),
                const SizedBox(
                  height: 20,
                ),
                linkText(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    color: seaBlue,
                    textButtonStyleFromSize: 16,
                    textStyleSize: 16,
                    text: 'Lupa password?')
              ],
            ),
          )),
        ),
      ),
    );
  }
}

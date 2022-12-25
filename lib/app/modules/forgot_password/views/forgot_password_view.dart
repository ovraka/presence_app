import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/custom_widget.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
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
                Obx(() => gradientButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.sendEmail();
                      }
                    },
                    buttonText: controller.isLoading.isFalse
                        ? 'Kirim untuk mereset password'
                        : 'Loading...')),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

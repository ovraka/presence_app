import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/custom_widget.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Password'),
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
                gradientButton(
                    onPressed: () {
                      controller.newPassword();
                    },
                    buttonText: 'SIMPAN'),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

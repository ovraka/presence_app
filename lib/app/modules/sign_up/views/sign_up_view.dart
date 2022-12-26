import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/data/theme/colors.dart';
import 'package:presence_app/app/data/theme/custom_widget.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pegawai'),
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
                    controller: controller.nipController,
                    hintText: 'NIP',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number),
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
                inputText(
                    readOnly: false,
                    controller: controller.emailController,
                    hintText: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                inputText(
                    readOnly: false,
                    controller: controller.jobTitleController,
                    hintText: 'Jabatan',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => gradientButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.addPegawai();
                      }
                    },
                    buttonText: controller.isLoading.isFalse
                        ? 'Tambah Pegawai'
                        : 'Loading...'))
              ],
            ),
          )),
        ),
      ),
    );
  }
}

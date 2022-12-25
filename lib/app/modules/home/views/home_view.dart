import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: const Icon(Icons.person))
        ],
      ),
      body: const Center(
        child: Text(
          'Home page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

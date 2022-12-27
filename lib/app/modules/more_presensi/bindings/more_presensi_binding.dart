import 'package:get/get.dart';

import '../controllers/more_presensi_controller.dart';

class MorePresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MorePresensiController>(
      () => MorePresensiController(),
    );
  }
}

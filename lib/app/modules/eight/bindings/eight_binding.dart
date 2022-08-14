import 'package:get/get.dart';

import '../controllers/eight_controller.dart';

class EightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EightController>(
      () => EightController(),
    );
  }
}

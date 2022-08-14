import 'package:get/get.dart';

import '../controllers/multiplayer_controller.dart';

class MultiplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiplayerController>(
      () => MultiplayerController(),
    );
  }
}

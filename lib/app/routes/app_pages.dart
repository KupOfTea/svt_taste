import 'package:get/get.dart';

import '../modules/eight/bindings/eight_binding.dart';
import '../modules/eight/views/eight_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_page.dart';
import '../modules/home/views/home_view.dart';
import '../modules/multiplayer/bindings/multiplayer_binding.dart';
import '../modules/multiplayer/views/multiplayer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MULTIPLAYER,
      page: () => const MultiplayerView(),
      binding: MultiplayerBinding(),
    ),
    GetPage(
      name: _Paths.EIGHT,
      page: () => EightView(),
      binding: EightBinding(),
    ),
  ];
}

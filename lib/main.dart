import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "세븐틴 취향표",
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xFFF7CAC9),
              secondary: Color(0xFF92A8D1),
            ),
          ),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        );
      },
    ),
  );
}

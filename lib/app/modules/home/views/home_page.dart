import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svt_taste/app/modules/home/controllers/home_controller.dart';
import 'package:svt_taste/app/modules/multiplayer/views/multiplayer_view.dart';
import 'package:svt_taste/app/routes/app_pages.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '세븐틴 취향표',
          style: GoogleFonts.getFont(
            'Jua',
            fontSize: 24.sp,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Image.asset(
              "assets/images/app-icon.png",
              height: Get.width * 0.5,
            ),
            Center(
              child: Text(
                "개발자 타이가 @DevvTyga",
                style: GoogleFonts.notoSans(
                  fontSize: 13.sp,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.MULTIPLAYER);
              },
              child: Container(
                margin: EdgeInsets.all(50),
                width: 164,
                height: 52,
                child: Center(
                  child: Text(
                    '시작',
                    style: GoogleFonts.notoSans(
                      color: Color(0xffffffff),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.523076923076923,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        offset: Offset(0, 8),
                        blurRadius: 16,
                        spreadRadius: 0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:screenshot/screenshot.dart';
import 'package:svt_taste/app/data/member.dart';
import 'package:svt_taste/app/data/seventeen.dart';
import 'package:svt_taste/app/modules/home/widgets/gradient_text.dart';
import 'package:svt_taste/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final ScreenshotController screenCtrl = ScreenshotController();
  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.EIGHT);
                },
                child: Container(
                  margin: EdgeInsets.all(50),
                  width: 164,
                  height: 52,
                  child: Center(
                    child: Text(
                      '8문항 버전 가기',
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
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          offset: Offset(0, 8),
                          blurRadius: 16,
                          spreadRadius: 0)
                    ],
                  ),
                ),
              ),
              SelectableText(
                "캡처해서 쓰세요!",
                style: GoogleFonts.getFont(
                  'Jua',
                  fontSize: 24.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                child: Text(
                  "개발자 타이가 @DeveloperTyga",
                  style: GoogleFonts.notoSans(
                    fontSize: 13.sp,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // nameTextField(context, nameCtrl, "닉네임"),
              // SizedBox(height: 20),
              Screenshot(
                child: Container(
                  width: Get.width * 0.99,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          typePink(
                            context,
                            "최애",
                            controller.choiae,
                            controller.choiaeIdx,
                          ),
                          typeBlue(
                            context,
                            "차애",
                            controller.chaae,
                            controller.chaaeIdx,
                          ),
                          typePink(
                            context,
                            "친구",
                            controller.friend,
                            controller.friendIdx,
                          ),
                          typeBlue(
                            context,
                            "애인",
                            controller.bf,
                            controller.bfIdx,
                          ),
                          typePink(
                            context,
                            "결혼",
                            controller.wedding,
                            controller.weddingIdx,
                          ),
                          typeBlue(
                            context,
                            "육아",
                            controller.kid,
                            controller.kidIdx,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                controller: screenCtrl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  typeBlue(
    BuildContext context,
    String title,
    ctrlMember,
    ctrlIndex,
  ) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$title',
              style: GoogleFonts.notoSans(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.523076923076923,
              ),
            ),
            SizedBox(height: 10.h),
            ctrlMember != Rxn<Member>()
                ? Column(
                    children: [
                      Image.asset(
                        ctrlMember.value!.img,
                        width: 30.w,
                        height: 30.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${ctrlMember.value!.name}',
                        style: GoogleFonts.notoSans(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.523076923076923,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      IconButton(
                        onPressed: () {
                          openBottomSheet(title, ctrlMember);
                        },
                        icon: Icon(Icons.change_circle),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      openBottomSheet(title, ctrlMember);
                    },
                    icon: Icon(Icons.image_outlined),
                  ),
          ],
        );
      },
    );
  }

  Container nameTextField(context, ctrl, text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: ctrl,
        onChanged: (text) {
          controller.name.value = text;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 1.0),
          ),
          labelText: text,
        ),
        maxLines: 1,
        maxLength: 4,
      ),
    );
  }

  profile(
    BuildContext context,
  ) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '이름',
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.523076923076923,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '${controller.name.value}',
              style: GoogleFonts.notoSans(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.523076923076923,
              ),
            ),
            SizedBox(height: 10.h),
            Column(
              children: [
                SizedBox(
                  width: 30.w,
                  height: 30.w,
                ),
                SizedBox(height: 10.h),
                Text(
                  '',
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.523076923076923,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.change_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  typePink(
    BuildContext context,
    String title,
    ctrlMember,
    ctrlIndex,
  ) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$title',
              style: GoogleFonts.notoSans(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.523076923076923,
              ),
            ),
            SizedBox(height: 10.h),
            ctrlMember != Rxn<Member>()
                ? Column(
                    children: [
                      Image.asset(
                        ctrlMember.value!.img,
                        width: 30.w,
                        height: 30.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${ctrlMember.value!.name}',
                        style: GoogleFonts.notoSans(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.523076923076923,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      IconButton(
                        onPressed: () {
                          openBottomSheet(title, ctrlMember);
                        },
                        icon: Icon(Icons.change_circle),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      openBottomSheet(title, ctrlMember);
                    },
                    icon: Icon(Icons.image_outlined),
                  ),
          ],
        );
      },
    );
  }

  void openBottomSheet(String title, Rxn<Member> ctrlMember) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.5.h),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView(
              controller: scrollController,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: 30.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 32, horizontal: 19.5),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          spacing: 6.5, // 상하(좌우) 공간
                          runSpacing: 12, // 좌우(상하) 공간
                          children: List.generate(
                            svt.length,
                            (index) => GestureDetector(
                              onTap: () {
                                ctrlMember.value = svt[index];
                                Get.back();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    svt[index].img,
                                    width: 35.w,
                                    height: 35.w,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: svt[index].name ==
                                              ctrlMember.value?.name
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(16.5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 8.h),
                                    child: Text(
                                      svt[index].name,
                                      style: GoogleFonts.notoSans(
                                        color: svt[index].name ==
                                                ctrlMember.value?.name
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                            : Colors.grey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }

  Widget svtTaste(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        svtText(context),
        Text(
          " ",
          style: GoogleFonts.getFont(
            'Jua',
            fontSize: 20.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        taste(context),
      ],
    );
  }

  RichText taste(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "취",
        style: GoogleFonts.getFont(
          'Jua',
          fontSize: 20.sp,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          TextSpan(
            text: "향",
            style: GoogleFonts.getFont(
              'Jua',
              fontSize: 20.sp,
              color: Color(0xFFbeb9cc),
            ),
          ),
          TextSpan(
            text: "표",
            style: GoogleFonts.getFont(
              'Jua',
              fontSize: 20.sp,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  RichText svtText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "세",
        style: GoogleFonts.getFont(
          'Jua',
          fontSize: 20.sp,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          TextSpan(
            text: "븐",
            style: GoogleFonts.getFont(
              'Jua',
              fontSize: 20.sp,
              color: Color(0xFFbeb9cc),
            ),
          ),
          TextSpan(
            text: "틴",
            style: GoogleFonts.getFont(
              'Jua',
              fontSize: 20.sp,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:svt_taste/app/data/member.dart';
import 'package:svt_taste/app/data/seventeen.dart';

import '../controllers/eight_controller.dart';

class EightView extends GetView<EightController> {
  EightView({Key? key}) : super(key: key);
  final ScreenshotController screenCtrl = ScreenshotController();
  final TextEditingController nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '세븐틴 취향표 8문항',
          style: GoogleFonts.getFont(
            'Jua',
            fontSize: 24.sp,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.grey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  "개발자 타이가 @DevvTyga",
                  style: GoogleFonts.notoSans(
                    fontSize: 13.sp,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          typePink(
                            context,
                            "최애",
                            controller.choiae,
                          ),
                          typeBlue(
                            context,
                            "차애",
                            controller.chaae,
                          ),
                          typePink(
                            context,
                            "친구",
                            controller.friend,
                          ),
                          typeBlue(
                            context,
                            "애인",
                            controller.bf,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          typeBlue(
                            context,
                            "결혼",
                            controller.wedding,
                          ),
                          typePink(
                            context,
                            "이혼",
                            controller.divorce,
                          ),
                          typeBlue(
                            context,
                            "성격",
                            controller.personal,
                          ),
                          typePink(
                            context,
                            "육아",
                            controller.kid,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                controller: screenCtrl,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  changeButton(
                    "최애",
                    controller.choiae,
                  ),
                  changeButton(
                    "차애",
                    controller.chaae,
                  ),
                  changeButton(
                    "친구",
                    controller.friend,
                  ),
                  changeButton(
                    "애인",
                    controller.bf,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  changeButton(
                    "결혼",
                    controller.wedding,
                  ),
                  changeButton(
                    "이혼",
                    controller.divorce,
                  ),
                  changeButton(
                    "성격",
                    controller.personal,
                  ),
                  changeButton(
                    "육아",
                    controller.kid,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget changeButton(String title, ctrlMember) {
    return Column(
      children: [
        Text(
          '$title',
          style: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.523076923076923,
          ),
        ),
        IconButton(
          onPressed: () {
            openBottomSheet(title, ctrlMember);
          },
          icon: Icon(Icons.change_circle),
        ),
      ],
    );
  }

  typeBlue(
    BuildContext context,
    String title,
    ctrlMember,
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
                        width: 40.w,
                        height: 40.w,
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

  typePink(
    BuildContext context,
    String title,
    ctrlMember,
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
                        width: 40.w,
                        height: 40.w,
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
                        margin: EdgeInsets.symmetric(vertical: 32, horizontal: 19.5),
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
                                      color: svt[index].name == ctrlMember.value?.name
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(16.5),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                                    child: Text(
                                      svt[index].name,
                                      style: GoogleFonts.notoSans(
                                        color: svt[index].name == ctrlMember.value?.name
                                            ? Theme.of(context).colorScheme.onSurface
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
}

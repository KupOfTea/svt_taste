import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/multiplayer_controller.dart';

class MultiplayerView extends GetView<MultiplayerController> {
  const MultiplayerView({Key? key}) : super(key: key);
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
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Center(
              child: Text(
                '총 6인, 문제는 다섯 개입니다.',
                style: GoogleFonts.getFont(
                  'Jua',
                  fontSize: 24.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

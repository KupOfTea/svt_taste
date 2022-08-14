import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svt_taste/app/data/member.dart';

class HomeController extends GetxController {
  Rxn<Member> choiae = Rxn<Member>();
  Rxn<Member> chaae = Rxn<Member>();
  Rxn<Member> friend = Rxn<Member>();
  Rxn<Member> bf = Rxn<Member>();
  Rxn<Member> wedding = Rxn<Member>();
  Rxn<Member> kid = Rxn<Member>();

  RxnInt choiaeIdx = RxnInt();
  RxnInt chaaeIdx = RxnInt();
  RxnInt friendIdx = RxnInt();
  RxnInt bfIdx = RxnInt();
  RxnInt weddingIdx = RxnInt();
  RxnInt kidIdx = RxnInt();

  Rxn<Uint8List> imageBytes = Rxn<Uint8List>();
  Rx<String> name = "".obs;

  Rx<Color> nameColor = Color(0xFFF7CAC9).obs;
}

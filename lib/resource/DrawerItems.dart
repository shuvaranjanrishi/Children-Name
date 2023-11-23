import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/screen/about_screen.dart';
import 'package:children_name/screen/female_name_screen.dart';
import 'package:children_name/screen/krishna_name_screen.dart';
import 'package:children_name/screen/male_name_screen.dart';
import 'package:children_name/screen/rashi_screen.dart';
import 'package:flutter/material.dart';

class DrawerItems {
  static final drawerItemNames = [
    MyStrings.home,
    MyStrings.krishnaName,
    MyStrings.rashi,
    MyStrings.feedback,
    MyStrings.rating,
    MyStrings.appShare,
    MyStrings.appInfo
  ];

  static final drawerItemIcons = [
    Icons.home_outlined,
    Icons.list_outlined,
    Icons.ac_unit_outlined,
    Icons.send_outlined,
    Icons.reviews_outlined,
    Icons.share_outlined,
    Icons.account_box_outlined
  ];

  static final List<Widget> drawerPages = [
    const FemaleNameScreen(),
    const MaleNameScreen(),
    const KrishnaNameScreen(),
    const RashiScreen(),
    const AboutScreen()
  ];
}

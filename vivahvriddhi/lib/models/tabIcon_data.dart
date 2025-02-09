import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/bottombaricon/tab_1.png',
      selectedImagePath: 'assets/bottombaricon/tab_1.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottombaricon/tab_2.png',
      selectedImagePath: 'assets/bottombaricon/tab_2.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottombaricon/tab_5.png',
      selectedImagePath: 'assets/bottombaricon/tab_5.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottombaricon/tab_4.png',
      selectedImagePath: 'assets/bottombaricon/tab_4.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}

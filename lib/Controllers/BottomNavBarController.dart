import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stock_ticker/Screens/DashboardScreen.dart';
import 'package:stock_ticker/Screens/RandomUpdatesScreen.dart';

class BottomNavBarController extends GetxController {
  final GlobalKey<CurvedNavigationBarState> bottomNavGlobalKey =
      GlobalKey(debugLabel: 'btm_nav_bar');
  int page = 0;

  List<Map<String, dynamic>> navTitleScreenList = [
    {'title': 'Dashboard', 'screen': const DashboardScreen()},
    {'title': 'Update', 'screen': const RandomUpdatesScreen()},
  ];

  changePage(int newPage) {
    page = newPage;
    // bottomNavGlobalKey.currentState?.setPage(newPage);
    update();
  }
}

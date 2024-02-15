import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ticker/Controllers/BottomNavBarController.dart';
import 'package:stock_ticker/main.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GetBuilder is used to listen changes from getx controller and rebuild your UI
    return GetBuilder(
      init: BottomNavBarController(),
      // This builder will update as many time we update BottomNavBarController
      builder: (controller) => Scaffold(
          // used customized appbar
          appBar: myWidgets.myAppBar(
              controller.navTitleScreenList[controller.page]['title']),
          // buttons to change current UI
          bottomNavigationBar: CurvedNavigationBar(
            key: controller.bottomNavGlobalKey,
            items: const <Widget>[
              Icon(Icons.home_outlined, size: 30),
              Icon(Icons.list, size: 30),
            ],
            onTap: controller.changePage,
            height: 45,
          ),
          // it will show current screen UI
          body: controller.navTitleScreenList[controller.page]['screen']),
    );
  }
}

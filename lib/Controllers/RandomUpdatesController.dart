import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../main.dart';

class RandomUpdatesController extends GetxController {
  // will show loading
  bool isLoading = false;

  // It has list of all numbers which we get from socket.io server
  List list = [];

  // This controller is used to auto scroll top because adding new value on 0th Index
  final ScrollController scrollController = ScrollController();

  // latest / current number = number got from socket.io server | difference number will minus from 2 numbers
  int currentNumber = 0, differenceCountNumber = 0;

  // double percentageDifference = 0;

  // Below method will be called when RandomUpdatesScreen is in view and assign this controller
  @override
  void onInit() {
    super.onInit();
    if (!socket.connected) {
      socket.connect();
    }
    socket.on('randomNumber', (data) {
      list.insert(0, data);
      try {
        if (scrollController.hasClients) {
          scrollController.animateTo(0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      } catch (e) {
        debugPrint('RandomUpdate Controller | onInit: $e');
      }
      debugPrint('Received random number: $data');
      currentNumber = data;
      if (list.length >= 2) {
        // percentageDifference =
        //     ((currentNumber - secondLastValue) / secondLastValue) * 100;
        differenceCountNumber = currentNumber - list[1] as int;
      }
      update();
    });
  }

  // Below will run when controller is getting closed
  @override
  void onClose() {
    scrollController.dispose();
    socket.dispose();
    super.onClose();
  }

  // Below will run when controller is getting disposed
  @override
  void dispose() {
    scrollController.dispose();
    socket.dispose();
    super.dispose();
  }
}

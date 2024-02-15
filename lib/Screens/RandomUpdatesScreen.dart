import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stock_ticker/Controllers/RandomUpdatesController.dart';

class RandomUpdatesScreen extends StatelessWidget {
  const RandomUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: RandomUpdatesController(),
        builder: (controller) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Random Numbers:',
                // .sp is for responsive font size as per device pixel
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                'Current Number: ${controller.currentNumber}',
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                'Difference: ${controller.differenceCountNumber}',
                style: TextStyle(fontSize: 18.sp),
              ),
              const SizedBox(height: 10),
              Expanded(
                // StreamBuilder will listen changes and update UI
                child: StreamBuilder(
                  // Creating stream mean listenable so it can update ui as per data
                  stream: Stream.fromIterable(controller.list),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        // CircularProgressIndicator will show loading UI
                        child: CircularProgressIndicator(),
                      );
                    }
                    // ListView is used to build list and .builder is used to improve performance
                    // due to don't generate all list item at once, it will generate items
                    // when we need / we scroll there
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.list.length,
                      // itemBuilder method will be called for every item
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            controller.list[index].toString(),
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

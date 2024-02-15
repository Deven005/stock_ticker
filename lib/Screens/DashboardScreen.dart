import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stock_ticker/Controllers/DashboardController.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor(
                    searchController: controller.searchController,
                    builder: (BuildContext context,
                        SearchController searchController) {
                      return SearchBar(
                        controller: searchController,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          searchController.openView();
                        },
                        onChanged: (val) {
                          searchController.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder: (BuildContext context,
                        SearchController searchController) {
                      return List<String>.from(controller.symbolList)
                          .where((item) => item
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .map((item) => ListTile(
                                title: Text(item),
                                onTap: () {
                                  searchController.closeView(item);
                                },
                              ))
                          .toList();
                    }),
              ),
            ),
            SizedBox(
              height: 70.h,
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : controller.tableHeadings.isEmpty
                        ? const Text('No data to show!')
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                FittedBox(
                                  child: DataTable(
                                    showCheckboxColumn: false,
                                    columns: controller.tableHeadings,
                                    rows: controller.tableRows,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: controller.currentPage >= 1
                                          ? controller.decreaseCurrentPage
                                          : null,
                                      child: const Text('Previous Page'),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: controller.currentPage <
                                              (controller.allData.length /
                                                      controller.itemsPerPage)
                                                  .ceil()
                                          ? controller.increaseCurrentPage
                                          : null,
                                      child: const Text('Next Page'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increaseCurrentPage,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ticker/Apis/StocksApis.dart';

class DashboardController extends GetxController {
  List<DataColumn> tableHeadings = [];
  List<List<dynamic>> allData = [], currentPageData = [];
  List<DataRow> tableRows = [];
  List<String> symbolList = [];
  int itemsPerPage = 20, currentPage = 0, selectedRowCount = 0;
  bool isLoading = false;
  final SearchController searchController = SearchController();

  fetchStocksList() async {
    try {
      isLoading = true;
      currentPage = 0;
      update();
      tableHeadings = [];
      symbolList = [];
      allData = await StocksApis().processCsv();
      for (var (index, row) in allData.indexed) {
        row.removeAt(5);
        row.removeAt(4);
        row.insert(0, index == 0 ? "Sr. No" : index.toString());
        row.removeRange(4, 6);
        symbolList.add(row[1]);
      }
      symbolList.removeAt(0);
      for (var cell in allData[0]) {
        tableHeadings.add(DataColumn(label: Text(cell)));
      }
      allData.removeAt(0);
      setCurrentPageData();
    } catch (e) {
      isLoading = false;
      update();
      rethrow;
    }
  }

  setCurrentPageData() {
    isLoading = true;
    update();
    int start = currentPage * itemsPerPage;
    int end = (currentPage + 1) * itemsPerPage;
    if (start >= allData.length) {
      return []; // No more data to display
    }
    currentPageData = allData.sublist(start, end.clamp(0, allData.length));
    tableRows = [];
    for (var row in currentPageData) {
      List<DataCell> tmpCells = [];
      for (var cell in row) {
        tmpCells.add(DataCell(Text(cell.toString().length > 20
            ? '${cell.toString().substring(0, 20)}...'
            : cell.toString())));
      }
      tableRows.add(DataRow(
        cells: tmpCells,
        onSelectChanged: (value) {
          debugPrint('onSelectChanged | value: $value');
        },
      ));
    }
    isLoading = false;
    update();
  }

  increaseCurrentPage() {
    currentPage++;
    update();
    setCurrentPageData();
  }

  decreaseCurrentPage() {
    currentPage--;
    update();
    setCurrentPageData();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading = true;
      update();
      await fetchStocksList();
      searchController.addListener(() {
        debugPrint('searchController.text | ${searchController.text}');
        // StocksApis().searchEndpointApi(searchController.text);
      });
      isLoading = false;
      update();
    } catch (e) {
      debugPrint('DashboardController | onInit | $e');
      isLoading = false;
      update();
    }
  }

  closeAndDispose() {
    searchController.dispose();
  }

  @override
  void onClose() {
    closeAndDispose();
    super.onClose();
  }

  @override
  void dispose() {
    closeAndDispose();
    super.dispose();
  }
}

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../main.dart';

class StocksApis extends GetConnect {
  Future<List<List<dynamic>>> processCsv() async {
    final myData = await rootBundle.loadString('lib/Assets/listing_status.csv');
    return const CsvToListConverter().convert(myData, eol: "\n");
  }

  searchEndpointApi(String keywords) async {
    final Response response =
        await get('${utils.API_URL}&function=SYMBOL_SEARCH&keywords=$keywords');
    debugPrint('searchEndpointApi | response ${response.statusCode}');
    debugPrint('searchEndpointApi | response ${response.body}');
  }

// Future<List<List<dynamic>>> stockListingApi() async {
//   try {
//     // final Response response =
//     //     await get('${utils.API_URL}&function=LISTING_STATUS');
//     // debugPrint('stockListingApi | response ${response.statusCode}');
//     // debugPrint('stockListingApi | response ${response.body}');
//     // final List rows = response.body.split('\n');
//     final myData =
//         await rootBundle.loadString('lib/Assets/listing_status.csv');
//     // final parsedData = await compute(processCsv, myData);
//     return const CsvToListConverter().convert(myData, eol: "\n");
//     // final List rows = myData.split('\n');
//     // final parsedData = rows.map((row) => row.split(',')).toList();
//     // return parsedData;
//   } catch (e) {
//     rethrow;
//   }
// }
}

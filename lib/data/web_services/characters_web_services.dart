import 'dart:developer';

import 'package:breaking_bad_app/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      sendTimeout: 20 * 1000, //20 seconds..
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> fetchCharacters() async {
    return await dio.get('characters').then((value) {
      return value.data;
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<List<dynamic>> fetchQuotes(String charName) async {
    return await dio
        .get('quotes', queryParameters: {'author': charName}).then((value) {
      return value.data;
    }).catchError((error) {
      log(error.toString());
    });
  }
}

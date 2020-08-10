import 'dart:convert';
import 'package:http/http.dart';

class NewsData {
  String apiKey = 'c7e3c47bd12744909f5c4f86116057a7';

  Future<dynamic> getNewsData(
      String country, String category, int page, String query) async {
    Response response = await get(
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&page=$page&q=$query&apiKey=$apiKey');

    if (response.statusCode == 200) {
      var data = response.body;
      var newsData = jsonDecode(data);
      return newsData;
    } else {
      throw Exception('Something\'s Wrong...');
    }
  }
}

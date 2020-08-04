import 'dart:convert';
import 'package:http/http.dart';

class NewsData {
  String apiKey = 'GET_API_KEY_FROM_NEWS_API_DOT_ORG';

  Future<dynamic> getNewsData(String country, String category) async {
    Response response = await get(
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey');

    if (response.statusCode == 200) {
      var data = response.body;
      var newsData = jsonDecode(data);
      return newsData;
    } else {
      throw Exception('Something\'s Wrong...');
    }
  }
}

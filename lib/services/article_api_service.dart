import 'package:flutter/foundation.dart';
import 'package:web_example/domain/article.dart';
import 'package:web_example/infrastructure/network_client.dart';

class ArticleApiService {

  late NetworkClient _client;

  ArticleApiService() {
    _client = NetworkClient();
  }

  Future<List<Article>?> getTopArticles() async {
    try {
      final response = await _client.client.get('https://newsapi.org/v2/top-headlines?country=de');
      final articles = response.data['articles']
          .map<Article>((e) => Article.fromJson(e))
          .toList() as List<Article>;
      return articles;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


}
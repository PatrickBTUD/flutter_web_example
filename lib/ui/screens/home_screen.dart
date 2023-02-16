import 'package:flutter/material.dart';
import 'package:flutter_web_example/domain/article.dart';
import 'package:flutter_web_example/services/article_api_service.dart';
import 'package:flutter_web_example/ui/screens/adaptive_scaffold_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>?>(
      future: ArticleApiService().getTopArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Es ist ein Fehler aufgetreten, bitte Laden Sie die Seite erneut'),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          final articles = snapshot.data;
          if (articles != null && articles.isNotEmpty) {
            return AdaptiveScaffoldScreen(
              articles: articles,
            );
          }
          return const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Es konnten keine Artikel geladen werden, bitte Laden Sie die Seite erneut'),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

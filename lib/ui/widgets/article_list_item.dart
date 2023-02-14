import 'package:flutter/material.dart';
import 'package:web_example/domain/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  const ArticleListItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.urlToImage != null ? Image.network(article.urlToImage!) : null,
      title: Text(article.title ?? 'Default Title'),
      subtitle: article.publishedAt != null ? Text(article.publishedAt!) : null,
    );
  }
}

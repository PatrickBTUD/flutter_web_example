import 'package:flutter/material.dart';
import 'package:flutter_web_example/domain/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  const ArticleListItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.urlToImage != null
          ? SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                article.urlToImage!,
                fit: BoxFit.contain,
              ),
            )
          : null,
      title: Text(article.title ?? 'Default Title'),
      subtitle: article.publishedAt != null ? Text(article.publishedAt!) : null,
    );
  }
}

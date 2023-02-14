import 'package:flutter/material.dart';
import 'package:web_example/domain/article.dart';

class FullScreenArticle extends StatelessWidget {
  final Article article;

  const FullScreenArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.contain,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 16,
            ),
            Text(
              article.title ?? 'Default Title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              article.description ?? 'Default description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              article.content ?? 'Default content',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              article.author ?? 'Default author',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_web_example/domain/article.dart';
import 'package:flutter_web_example/ui/widgets/article_list_item.dart';
import 'package:flutter_web_example/ui/widgets/full_screen_article.dart';

class AdaptiveScaffoldScreen extends StatefulWidget {
  final List<Article> articles;

  const AdaptiveScaffoldScreen({Key? key, required this.articles}) : super(key: key);

  @override
  State<AdaptiveScaffoldScreen> createState() => _AdaptiveScaffoldScreenState();
}

class _AdaptiveScaffoldScreenState extends State<AdaptiveScaffoldScreen> {
  Article? _selectedArticle;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarTheme(
      data: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      child: AdaptiveScaffold(
        smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
        mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
        largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
        useDrawer: false,
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Login'),
          NavigationDestination(icon: Icon(Icons.article), label: 'Articles'),
        ],
        body: (_) => GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          children: _generateGridViewChildrenWidgets(context, widget.articles),
        ),
        smallBody: (_) => ListView.builder(
          itemCount: widget.articles.length,
          itemBuilder: (_, int idx) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedArticle = widget.articles[idx];
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FullScreenArticle(
                        article: widget.articles[idx],
                      );
                    },
                  ),
                );
              },
              child: ArticleListItem(
                article: widget.articles[idx],
              ),
            );
          },
        ),
        secondaryBody: (context) {
          return FullScreenArticle(
            article: _selectedArticle ?? widget.articles.first,
          );
        },
        smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
      ),
    );
  }

  List<Widget> _generateGridViewChildrenWidgets(
      final BuildContext context, final List<Article> articles) {
    return articles.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedArticle = e;
          });
        },
        child: Stack(
          children: [
            e.urlToImage != null
                ? Image.network(
                    e.urlToImage!,
                    fit: BoxFit.fill,
                  )
                : const Center(
                    child: Icon(
                      Icons.article_outlined,
                      color: Color(0xFF333333),
                      size: 80,
                    ),
                  ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00000000),
                      Color(0xFF111111),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.title ?? 'Default Article',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

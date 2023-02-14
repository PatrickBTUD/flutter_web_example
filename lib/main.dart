import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:web_example/domain/article.dart';
import 'package:web_example/services/article_api_service.dart';
import 'package:web_example/ui/widgets/article_list_item.dart';
import 'package:web_example/ui/widgets/full_screen_article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Article? _selectedArticle;

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
                child:
                    Text('Es ist ein Fehler aufgetreten, bitte Laden Sie die Seite erneut'),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          final articles = snapshot.data;
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
                children: _generateGridViewChildrenWidgets(context, articles),
              ),
              smallBody: (_) => ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (_, int idx) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedArticle = articles[idx];
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FullScreenArticle(
                              article: articles[idx],
                            );
                          },
                        ),
                      );
                    },
                    child: ArticleListItem(
                      article: articles![idx],
                    ),
                  );
                },
              ),
              secondaryBody: (context) {
                _selectedArticle = articles?.first;
                if (_selectedArticle != null) {
                  return FullScreenArticle(
                    article: _selectedArticle!,
                  );
                }
                return const SizedBox();
              },
              smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  List<Widget> _generateGridViewChildrenWidgets(
      final BuildContext context, final List<Article>? articles) {
    if (articles == null) return [];
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

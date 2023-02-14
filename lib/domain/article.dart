import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final String? title;
  final String? urlToImage;
  final String? author;
  final String? description;
  final String? url;
  final String? publishedAt;
  final String? content;

  Article({
    this.title,
    this.urlToImage,
    this.author,
    this.description,
    this.url,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      title: json['title'] as String?,
      urlToImage: json['urlToImage'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'urlToImage': instance.urlToImage,
      'author': instance.author,
      'description': instance.description,
      'url': instance.url,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

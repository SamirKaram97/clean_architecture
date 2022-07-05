import 'package:flutter/foundation.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';

class PostModel extends Post
{
  const PostModel({required super.id, required super.body, required super.title});

  factory PostModel.fromJson(Map<String,dynamic> json)
  {
    return PostModel(id: json['id'], body: json['body'], title: json['title']);
  }

  Map<String,dynamic> toJson()
  {
    return {
      'id':id,
      'body':body,
      'title':title
    };
  }
}
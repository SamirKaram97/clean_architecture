import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class LocalDataSource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postsModel);
}

const CACHED_POSTS = "CACHED_POSTS";
//store as string
//recieve as string then convert it to List of map<> then convert it to list of model to view

class LocalDataSourceImplShared implements LocalDataSource
{
  final SharedPreferences sharedPreferences;
  LocalDataSourceImplShared({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postsModel)async {
    List<Map<String,dynamic>> postsModelJson=postsModel.map<Map<String,dynamic>>((e) => e.toJson()).toList();
    await sharedPreferences.setString(CACHED_POSTS, jsonEncode(postsModelJson));
    return Future.value(unit);
  }
  @override
  Future<List<PostModel>> getCachedPosts() {
    String ?postsModelString=sharedPreferences.getString(CACHED_POSTS);
    if(postsModelString!=null)
      {
        List<Map<String,dynamic>> postsModelJson=json.decode(postsModelString);
        List<PostModel> postsModel=postsModelJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
        return Future.value(postsModel);
      }
    else
      {
        throw EmptyCacheException();
      }
  }

}





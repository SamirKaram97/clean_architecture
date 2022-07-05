import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:posts_clean_architecture/core/error/exceptions.dart';

import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';

abstract class RemoteDataSource {

  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> addPost(PostModel postModel);

  Future<Unit> updatePost(PostModel postModel);
}



const  BASE_URL="https://jsonplaceholder.typicode.com";
const  GET_ALL_POSTS="/posts/";
const  ADD_POST="/posts/";
const  DELETE_POST="/posts/";
const  UPDATE_POST="/posts/";
class RemoteDataSourceImplHttp implements RemoteDataSource
{
  final http.Client client;
  RemoteDataSourceImplHttp({required this.client});
  @override
  Future<List<PostModel>> getAllPosts()async {
    var response=await client.get(Uri.parse(BASE_URL+GET_ALL_POSTS),headers: {"Content-Type": "application/json"});
    if(response.statusCode==200)
      {
        List postsModelJson=jsonDecode(response.body);
        List<PostModel> postsModel=postsModelJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
        return postsModel;
      }
    else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> addPost(PostModel postModel)async {
    var response=await client.put(Uri.parse(BASE_URL+ADD_POST+1.toString()),body: {
      'title':postModel.title,
      'body':postModel.body
    });
    if(response.statusCode==200)
      {
        return Future.value(unit);
      }
    else
      {
        print(response.statusCode);
        throw ServerException();
      }
  }

  @override
  Future<Unit> deletePost(int id)async {
    var response=await http.delete(Uri.parse(BASE_URL+DELETE_POST+id.toString()),);
    if(response.statusCode==200)
      {
        return Future.value(unit);
      }
    else
      {
        throw ServerException();
      }
  }



  @override
  Future<Unit> updatePost(PostModel postModel)async {
    var response=await http.patch(Uri.parse(BASE_URL+UPDATE_POST+postModel.id.toString()),body: {'title':postModel.title,'body':postModel.body});
    if(response.statusCode==200)
      {
        return Future.value(unit);
      }
    else
      {
        throw ServerException();
      }
  }

}


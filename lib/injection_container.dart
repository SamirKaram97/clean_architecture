import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/Posts_repository_impl.dart';
import 'package:posts_clean_architecture/features/posts/domin/repositories/posts_repository.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/update_post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_update_delete_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/data_sources/local_data_source.dart';

final sl=GetIt.instance;

init()async
{
  //! feature -posts

  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddUpdateDeleteBloc(addPostUseCase: sl(),deletePost: sl(),updatePostUseCase: sl()));

  //use cases
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  //repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  //data sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplShared(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplHttp(client: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() =>NetworkInfoImpl(sl()));

  //external
  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());







}
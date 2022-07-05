import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_update_delete_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/add_update_post_screen.dart';
import 'package:posts_clean_architecture/injection_container.dart' as dl;
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observier.dart';
import 'core/app_themes.dart';
import 'features/posts/data/repositories/Posts_repository_impl.dart';
import 'package:http/http.dart' as http;

import 'features/posts/domin/repositories/posts_repository.dart';
import 'features/posts/presentation/pages/posts_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dl.init();
  BlocOverrides.runZoned(
        () {
          runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostsBloc(getAllPostsUseCase: dl.sl())..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => AddUpdateDeleteBloc(updatePostUseCase: dl.sl(),deletePost: dl.sl(),addPostUseCase: dl.sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home:  PostsPage(),
      ),
    );
  }
}
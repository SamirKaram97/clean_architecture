import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exceptions.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import '../../domin/repositories/posts_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    if (await networkInfo.isNetworkConnectionWork()) {
      try {
        var allPosts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(allPosts);
        return right(allPosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        var chachedPosts = await localDataSource.getCachedPosts();
        return right(chachedPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    return await shortCut((){
      return remoteDataSource.addPost(PostModel(id: post.id,body: post.body,title: post.title));
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await shortCut((){
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    return await shortCut((){
      return remoteDataSource.updatePost(PostModel(id: post.id, body: post.body, title: post.title));
    });
  }

  Future<Either<Failure, Unit>> shortCut(Future<Unit> Function() updateOrDeleteOrAddPost)async {
    if (await networkInfo.isNetworkConnectionWork()) {
      try {
        updateOrDeleteOrAddPost();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}

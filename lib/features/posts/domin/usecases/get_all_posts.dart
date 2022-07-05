import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domin/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUseCase
{
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure,List<Post>>> call() async
  {
    return await repository.getAllPosts();
  }
}
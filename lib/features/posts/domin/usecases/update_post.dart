import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domin/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase
{
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Post post) async
  {
    return await repository.updatePost(post);
  }
}


import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domin/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class DeletePost
{
  final PostsRepository repository;

  DeletePost(this.repository);

  Future<Either<Failure,Unit>> call(int id) async
  {
    return await repository.deletePost(id);
  }
}


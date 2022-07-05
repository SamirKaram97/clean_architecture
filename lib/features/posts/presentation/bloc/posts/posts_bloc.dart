import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/strings/failures.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      print(event.toString());
      if (event is GetAllPostsEvent) {
        emit(GetAllPostsLoadingState());
        final postOrFailure = await getAllPostsUseCase();

        emit(_mapPostsState(postOrFailure));
      } else if (event is RefreshPostsEvent) {
        emit(GetAllPostsLoadingState());
        final postOrFailure = await getAllPostsUseCase();

        emit(_mapPostsState(postOrFailure));
      }
    });
  }

  PostsState _mapPostsState(Either<Failure, List<Post>> postsOrFailure) {
    return postsOrFailure.fold(
      (failure) {
        return GetAllPostsFailureState(message: _mapFailureMessage(failure));
      },
      (posts) {
        return GetAllPostsLoadedState(posts: posts);
      },
    );
  }
  String _mapFailureMessage(Failure failure) {
    if (failure.runtimeType == OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure.runtimeType == ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else {
      return 'unexpected error';
    }
  }
}


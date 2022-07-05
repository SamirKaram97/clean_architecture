part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitialState extends PostsState {
  @override
  List<Object> get props => [];
}

class GetAllPostsLoadingState extends PostsState
{
  @override
  List<Object?> get props => [];

}

class GetAllPostsLoadedState extends PostsState
{
  final List posts;
  const GetAllPostsLoadedState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class GetAllPostsFailureState extends PostsState
{
  final String message;
  GetAllPostsFailureState({required this.message});

  @override
  List<Object?> get props => [message];

}

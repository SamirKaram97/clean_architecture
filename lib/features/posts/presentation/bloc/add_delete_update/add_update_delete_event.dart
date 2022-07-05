part of 'add_update_delete_bloc.dart';

abstract class AddUpdateDeleteEvent extends Equatable {
  const AddUpdateDeleteEvent();
}

class AddPostEvent extends AddUpdateDeleteEvent{
  final Post post;

  const AddPostEvent({required this.post});
  @override
  List<Object?> get props => [post];

}

class DeletePostEvent extends AddUpdateDeleteEvent{
  final int id;

  const DeletePostEvent({required this.id});

  @override
  List<Object?> get props => [id];

}

class UpdatePostEvent extends AddUpdateDeleteEvent{
  final Post post;

  UpdatePostEvent({required this.post});
  @override
  List<Object?> get props => [post];

}
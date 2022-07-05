part of 'add_update_delete_bloc.dart';

abstract class AddUpdateDeleteState extends Equatable {
  const AddUpdateDeleteState();
}

class AddUpdateDeleteInitialState extends AddUpdateDeleteState {
  @override
  List<Object> get props => [];
}

class LoadingAddUpdateDeleteState extends AddUpdateDeleteState {
  @override
  List<Object?> get props => [];

}

class LoadedAddUpdateDeleteState extends AddUpdateDeleteState {
  final String message;
  const LoadedAddUpdateDeleteState({required this.message});

  @override
  List<Object?> get props => [message];
}

class FailureAddUpdateDeleteState extends AddUpdateDeleteState {
  final String message;
  const FailureAddUpdateDeleteState({required this.message});

  @override
  List<Object?> get props => [message];

}
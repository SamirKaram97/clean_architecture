import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/strings/messages.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/domin/usecases/add_post.dart';
import 'package:posts_clean_architecture/core/strings/failures.dart';
import '../../../domin/entities/post.dart';
import '../../../domin/usecases/delete_post.dart';
import '../../../domin/usecases/update_post.dart';
part 'add_update_delete_event.dart';

part 'add_update_delete_state.dart';

class AddUpdateDeleteBloc
    extends Bloc<AddUpdateDeleteEvent, AddUpdateDeleteState> {
  final AddPostUseCase addPostUseCase;
  final DeletePost deletePost;
  final UpdatePostUseCase updatePostUseCase;

  AddUpdateDeleteBloc( {required this.updatePostUseCase,required this.deletePost,required this.addPostUseCase})
      : super(AddUpdateDeleteInitialState()) {
    on<AddUpdateDeleteEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final unitOrFailure = await addPostUseCase(event.post);
        emit(_mapState(unitOrFailure,event));
      }
      else if(event is DeletePostEvent)
        {
          emit(LoadingAddUpdateDeleteState());
          final unitOrFailure = await deletePost(event.id);

          emit(_mapState(unitOrFailure,event));
        }
      else if(event is UpdatePostEvent)
          {
            emit(LoadingAddUpdateDeleteState());
            final unitOrFailure = await updatePostUseCase(event.post);

            emit(_mapState(unitOrFailure,event));
          }
    });
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
  AddUpdateDeleteState _mapState(Either<Failure, Unit> unitOrFailure,AddUpdateDeleteEvent event) {
    return unitOrFailure.fold(
      (failure) {
        return FailureAddUpdateDeleteState(
            message: _mapFailureMessage(failure));
      },
      (unit) {
        return LoadedAddUpdateDeleteState(message: _mapAddDeleteUpdateMessage(event));
      },
    );
  }
  String _mapAddDeleteUpdateMessage(AddUpdateDeleteEvent event)
  {
    if(event is AddPostEvent)
      return ADD_SUCCESS_MESSAGE;
    else if(event is UpdatePostEvent)
      {
        return UPDATE_SUCCESS_MESSAGE;
      }
    else if(event is DeletePostEvent)
      {
        return DELETE_SUCCESS_MESSAGE;
      }
    else
      {
        return 'Unexpected event';
      }
  }
}

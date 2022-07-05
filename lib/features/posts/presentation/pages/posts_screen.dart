import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/add_update_post_screen.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/posts_widgets/message_widget.dart';
import '../widgets/posts_widgets/body_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: BlocBuilder<PostsBloc,PostsState>(
        builder: (context, state) {
          if(state is GetAllPostsLoadingState)
            {return const LoadingWidget();}
          else if(state is GetAllPostsLoadedState)
            {
              return RefreshIndicator(onRefresh: ()=>_refreash(context),child: BodyWidget(posts: state.posts,));
            }
          else if(state is GetAllPostsFailureState)
            {
              return MessageWidget(message:state.message);
            }
          else{
            return const LoadingWidget();
          }
        },
      ),
      floatingActionButton: _floatingWidget(context),
    );
  }

  AppBar _appBarWidget()=>AppBar(title: const Text('Posts'),);
  Widget _floatingWidget(context)=>FloatingActionButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdatePostScreen(isAdd: true),));
  },child: const Icon(Icons.add),);
  Future<void> _refreash(BuildContext context)async
  {
     BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}

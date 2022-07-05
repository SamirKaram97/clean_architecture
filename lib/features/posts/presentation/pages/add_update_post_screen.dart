import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/app_themes.dart';
import 'package:posts_clean_architecture/core/util/snack_bar.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_update_delete_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_screen.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/add_delete_update_widgets/form_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/posts_widgets/message_widget.dart';

class AddUpdatePostScreen extends StatelessWidget {
  const AddUpdatePostScreen({Key? key, required this.isAdd,this.post}) : super(key: key);
  final bool isAdd;
  final Post? post;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState>(
        listener: (context,state){
          if(state is LoadedAddUpdateDeleteState)
            {
              _addedPostSuccess(context,state.message);
            }
          if(state is FailureAddUpdateDeleteState)
            {
              _addedPostError(context,state.message);
            }
        },
    builder: (context, state) {
    return FormWidget(isAdd:isAdd,post: post,state:state);
  },
),

    );
  }

  void _addedPostError(context,String message)
  {
    SnackBarUtil().errorSnackBar(context: context, message: message);
  }
  void _addedPostSuccess(context,String message)
  {
    SnackBarUtil().successSnackBar(context: context, message: message);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PostsPage(),), (route) => false);
  }
}

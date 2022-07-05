import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/app_themes.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/add_delete_update_widgets/submit_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/add_delete_update_widgets/text_form_filed_widget.dart';

import '../../bloc/add_delete_update/add_update_delete_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isAdd;
  final Post? post;
  final AddUpdateDeleteState state;

  const FormWidget({Key? key, required this.isAdd, this.post, required this.state}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController titleController=TextEditingController();
  final TextEditingController bodyController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  _FormWidgetState();
  @override
  void initState()
  {
    if(!widget.isAdd)
      {
        titleController.text=widget.post!.title;
        bodyController.text=widget.post!.body;
      }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('title',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(controller:titleController,name:'title',multiLine:false),
              const SizedBox(
                height: 10,
              ),
              const Text('body',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(controller:bodyController,name:'body',multiLine:true),
              const SizedBox(height: 220,),
              SubmitWidget(name:widget.isAdd?'Add Post':'Update Post', onPressed: _validateAddOrUpdate,),
              SizedBox(height: 10,),
              if(widget.state is LoadingAddUpdateDeleteState)
                const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
  void _validateAddOrUpdate()
  {
    if(formKey.currentState!.validate()) {
      if (widget.isAdd)
      {BlocProvider.of<AddUpdateDeleteBloc>(context).add(
          AddPostEvent(post: Post(title: titleController.text,
              body: bodyController.text,
              id: 10)));}
      else
      {BlocProvider.of<AddUpdateDeleteBloc>(context).add(
          UpdatePostEvent(post: Post(id: 1,
              body: bodyController.text,
              title: titleController.text)));}
    }
  }

}

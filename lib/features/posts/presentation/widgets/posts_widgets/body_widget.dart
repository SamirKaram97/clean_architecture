import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/add_update_post_screen.dart';

class BodyWidget extends StatelessWidget {
  final List posts;

  const BodyWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) =>_buildListView(posts,index,context),
        separatorBuilder: (context, index) =>
        const Divider(height: 1, color: Colors.black,),
        itemCount: posts.length);
  }
}

Widget _buildListView(List posts, int index,context) {
  return ListTile(title: Text(
    posts[index].title, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdatePostScreen(isAdd: false,post: posts[index]),));
    },
    leading:Text(posts[index].id.toString()),
    subtitle: Text(posts[index].body,style:const TextStyle(fontSize: 20,),),
  );
}

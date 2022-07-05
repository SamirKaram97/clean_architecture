import 'package:flutter/material.dart';

import '../app_themes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: secondaryColor,),);
  }
}

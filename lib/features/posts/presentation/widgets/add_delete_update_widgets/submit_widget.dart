import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/core/app_themes.dart';

class SubmitWidget extends StatelessWidget {
  final String name;
  final void Function() onPressed;
  const SubmitWidget({Key? key, required this.name, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: primaryColor,
      onPressed: onPressed,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

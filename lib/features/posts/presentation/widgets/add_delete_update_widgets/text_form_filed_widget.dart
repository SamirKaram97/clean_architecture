import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLine;
  final String name;

  const TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.multiLine,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: name),
      minLines: multiLine ? 6 : 1,
      maxLines: multiLine ? 6 : 1,
      controller: controller,
      validator: (String? v) {
        if (v!.isEmpty) {
          return '$name can not be empty';
        } else {
          return null;
        }
      },
    );
  }
}

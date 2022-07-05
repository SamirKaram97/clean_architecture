import 'package:flutter/material.dart';

class SnackBarUtil
{
  void successSnackBar({required context,required String message})
  {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.green,));
  }

  void errorSnackBar({required context,required String message})
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));
  }
}
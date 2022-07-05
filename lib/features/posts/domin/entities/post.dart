import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Post extends Equatable
{
   final int id;
   final String body;
   final String title;
   const Post({required this.id,required this.body, required this.title});

  @override
  List<Object?> get props => [id,body,title];
}
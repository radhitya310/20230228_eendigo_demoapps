// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PageBase extends StatefulWidget {
  Widget body;

  PageBase({required this.body})
      : assert(body != null);

  @override
  State<PageBase> createState() => _PageBaseState();
}

class _PageBaseState extends State<PageBase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("Assets/img/background-eendigo_(1).png"),
        fit: BoxFit.cover,
      )),
      child: widget.body,
    );
  }
}
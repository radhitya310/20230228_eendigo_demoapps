import 'package:flutter/cupertino.dart';

BoxDecoration BackgroundImage() {
  return const BoxDecoration(
      image: DecorationImage(
    image: AssetImage("Assets/img/background-eendigo_(1).png"),
    fit: BoxFit.cover,
  ));
}
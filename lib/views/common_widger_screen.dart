import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

Widget customTextField({String? title, hint, controller, required bool obs}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            obscureText: obs,
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color.fromARGB(238, 2, 25, 88),
              ),
            ),
          ),
        )
            .box
            .color(Color.fromARGB(255, 255, 255, 255))
            .width(300)
            .height(50)
            .shadow2xl
            .rounded
            .make(),
      ],
    ),
  );
}

Widget customButton({
  String? title,
}) {
  return Center(child: title!.text.white.semiBold.size(17).make())
      .box
      .height(50)
      .width(180)
      .rounded
      .shadow3xl
      .color(Color.fromARGB(255, 202, 2, 252))
      .make();
}

import 'dart:io';
import 'package:relative_scale/relative_scale.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageBox extends StatelessWidget {
  File _image;

  ImageBox(this._image);

  @override
  Widget build(BuildContext context) {
    return _image != null
        ? RelativeBuilder(
            builder: (context, screenHeight, screenWidth, sy, sx) {
            return Container(
              width: sy(220),
              height: sy(220),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    image: FileImage(_image), fit: BoxFit.cover),
              ),
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            );
          })
        : Container();
  }
}

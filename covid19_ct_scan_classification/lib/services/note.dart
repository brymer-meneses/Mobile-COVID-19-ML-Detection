import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xff273c75),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: sy(175),
        width: sy(200),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Text(
                'NOTE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              )),
          Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: sy(12.5), color: Colors.white),
                softWrap: true,
                child: Text(
                  "To get an accurate classification, crop the " +
                      "image to only show the lung part of the CT-scan. " +
                      "Minimizing what the AI sees will yield higher accuracy. " +
                      "Take this in mind when using the camera to get the image as well.",
                  textAlign: TextAlign.center,
                ),
              ))
        ]),
      );
    });
  }
}

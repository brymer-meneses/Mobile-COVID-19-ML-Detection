import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'note.dart';

class ChooseImageMethod extends StatelessWidget {
  final bool _showPrompt;
  final _selectCameraHandler;
  final _selectGalleryHandler;

  ChooseImageMethod(
      this._showPrompt, this._selectGalleryHandler, this._selectCameraHandler);
  @override
  Widget build(BuildContext context) {
    return _showPrompt
        ? RelativeBuilder(
            builder: (context, screenHeight, screenWidth, sy, sx) {
            return Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.all(30),
                child: Container(
                  width: sy(200),
                  height: sy(200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xff273c75),
                          ),
                          height: sy(30),
                          width: sx(300),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Image Source',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      Container(
                        child: FloatingActionButton.extended(
                          onPressed: _selectGalleryHandler,
                          label: Text('Gallery'),
                          backgroundColor: Color(0xff487eb0),
                          icon: Icon(Icons.image),
                        ),
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                      ),
                      Container(
                          child: FloatingActionButton.extended(
                            onPressed: _selectCameraHandler,
                            label: Text('Camera'),
                            backgroundColor: Color(0xff487eb0),
                            icon: Icon(Icons.camera),
                          ),
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10))
                    ],
                  ),
                ),
              ),
              Note()
            ]);
          })
        : Container(); // show empty container
  }
}

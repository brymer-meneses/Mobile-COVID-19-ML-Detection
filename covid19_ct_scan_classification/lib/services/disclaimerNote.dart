import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class DisclaimerNote extends StatelessWidget {
  final _showDisclaimerNote;

  DisclaimerNote(this._showDisclaimerNote);
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
      return _showDisclaimerNote
          ? Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xffc23616),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: sy(150),
              width: sy(200),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Text(
                          'WARNING',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: sy(18),
                          ),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: sy(12.5), color: Colors.white),
                          softWrap: true,
                          child: Text(
                            "The A.I. model used for this application " +
                                'has not been tested on "real world data" but  ' +
                                "only on anonymized datasets provided online. " +
                                "Use this application at your own risk. ",
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ]),
            )
          : Container();
    });
  }
}

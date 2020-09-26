import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'package:covid19_ct_scan_classification/services/displayTopResult.dart';
import 'package:covid19_ct_scan_classification/services/categoryResult.dart';

// ignore: must_be_immutable
class Results extends StatelessWidget {
  final num _covidPercent;
  final num _nonCovidPercent;
  final num _nonInformativePercent;

  final Color _covidColor = Color(0xffc23616);
  final Color _nonCovidColor = Color(0xff44bd32);
  final Color _nonInformativeColor = Color(0xff0097e6);

  final String _covidLabel = 'COVID-19';
  final String _nonCovidLabel = 'NON-COVID-19';
  final String _nonInformativeLabel = 'NON-INFORMATIVE';

  Results(
      this._covidPercent, this._nonCovidPercent, this._nonInformativePercent);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
      return Column(children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          width: sy(220),
          height: sy(175),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DisplayTopResult(
                  _covidPercent, _nonCovidPercent, _nonInformativePercent),
              CategoryResult(_covidPercent, _covidColor, _covidLabel),
              CategoryResult(_nonCovidPercent, _nonCovidColor, _nonCovidLabel),
              CategoryResult(_nonInformativePercent, _nonInformativeColor,
                  _nonInformativeLabel),
            ],
          ),
        ),
      ]);
    });
  }
}

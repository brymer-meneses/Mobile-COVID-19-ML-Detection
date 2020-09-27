import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

// ignore: must_be_immutable
class DisplayTopResult extends StatelessWidget {
  final num _covidPercent;
  final num _nonCovidPercent;
  final num _nonInformativePercent;

  List _allValues;

  String _status;
  String _resultDescription;
  Color _color;

  DisplayTopResult(
      this._covidPercent, this._nonCovidPercent, this._nonInformativePercent) {
    _allValues = [_covidPercent, _nonCovidPercent, _nonInformativePercent];
    _getTopResult();
  }

  num _round(num number) {
    num roundedNumber = num.parse(number.toStringAsFixed(5));
    return roundedNumber;
  }

  void _getTopResult() {
    var _largestValue = _allValues[0];

    _allValues.forEach((e) => {
          if (e > _largestValue) {_largestValue = e},
        });

    var _index = _allValues.indexOf(_largestValue);

    if (_largestValue < .60) {}

    if (_index == 0) {
      _status = 'COVID-19 DETECTED';
      _resultDescription =
          "The A.I. model is ${(_round(_largestValue)) * 100}% " +
              "sure that the CT-Scan belongs to a COVID-19 infected patient. ";
      _color = Color(0xffc23616);
    } else if (_index == 1) {
      _status = 'COVID-19 NOT DETECTED';
      _resultDescription = 'The A.I. model is ${(_round(_largestValue)) * 100}% ' +
          'sure that the CT-Scan belongs to a patient without COVID-19 infection.';
      _color = Color(0xff44bd32);
    } else {
      _status = 'IMAGE NON-INFORMATIVE';
      _resultDescription = 'The A.I. model is ${(_round(_largestValue)) * 100}% ' +
          'sure that COVID-19 infection cannot be deduced from the CT-Scan provided.';
      _color = Color(0xff0097e6);
    }

    if (_largestValue < .60) {
      _status = 'MODEL UNDECIDED';
      _resultDescription =
          'The A.I. model is not confident enough to make a conclusion.';
      _color = Color(0xff40739e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        return Tooltip(
          preferBelow: false,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          textStyle:
              TextStyle(color: Colors.white, wordSpacing: 5, letterSpacing: 1),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], color: _color, borderRadius: BorderRadius.all(Radius.circular(5))),
          message: _resultDescription,
          child: Container(
            width: sy(200),
            height: sy(25),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                _status,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    wordSpacing: 5),
              ),
            ),
            margin: EdgeInsets.only(bottom: sy(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: _color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:relative_scale/relative_scale.dart';

class CategoryResult extends StatelessWidget {
  final num _categoryPercent;
  final Color _color;
  final String _label;

  CategoryResult(this._categoryPercent, this._color, this._label);

  num _round(num number) {
    num roundedNumber = num.parse(number.toStringAsFixed(5));
    return roundedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                child: LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  animation: true,
                  animationDuration: 1000,
                  percent: _categoryPercent.toDouble(),
                  progressColor: _color,
                  width: sy(175),
                  lineHeight: sy(15),
                  backgroundColor: Color(0xffdcdde1),
                  center: new Text(
                    (_round(_categoryPercent) * 100).toString() + '%',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                margin: EdgeInsets.all(3),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              alignment: Alignment.center,
              child: Text(
                _label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff273c75),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

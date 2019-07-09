import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';

class CompletionProgressBar extends StatelessWidget {
  int totalSteps;
  int completedSteps;

  CompletionProgressBar({
    @required this.totalSteps,
    @required this.completedSteps
  });

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: IntervalProgressBar(
                  direction: IntervalProgressDirection.horizontal,
                  max: totalSteps,
                  progress: completedSteps,
                  intervalSize: 4,
                  size: Size(viewportConstraints.maxWidth, 12),
                  highlightColor: JepretColor.PRIMARY,
                  defaultColor: Colors.grey,
                  intervalColor: Colors.transparent,
                  intervalHighlightColor: Colors.transparent,
                  radius: 0
              ),
            ),
            _renderCircledIcon(
                Colors.white,
                JepretColor.PRIMARY_DARKER,
                Icon(Icons.check, color: JepretColor.PRIMARY_DARKER, size: 20,)
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  _getLeftPosition(
                      completedSteps, totalSteps, viewportConstraints.maxWidth
                  ), 0, 0, 0),
              child: _renderCircledIcon(
                  Colors.white,
                  JepretColor.PRIMARY_DARKER,
                  Icon(Icons.check, color: JepretColor.PRIMARY_DARKER, size: 20,)
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(viewportConstraints.maxWidth - 32, 0, 0, 0),
              child: _renderCircledIcon(
                  Colors.white,
                  Colors.grey,
                  Icon(Icons.star_border, color: Colors.grey, size: 20,)
              ),
            )
          ],
        );
      }
    );
  }

  Widget _renderCircledIcon(Color background, Color outline, Widget icon) {
    return Container(
        width: 32,
        height: 32,
        child: icon,
        decoration: new BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: outline, width: 4)
        )
    );
  }

  double _getLeftPosition(int completedSteps, int totalSteps, double maxWidth) {
    return ((completedSteps/totalSteps) * maxWidth) - 16;
  }
}
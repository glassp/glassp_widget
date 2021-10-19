import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../clipper/parallelogramm_clipper.dart';

/// The Logo for Glassp.dev as a Flutter Widget
class GlasspWidget extends StatelessWidget {
  /// The height the Widget should get
  final double height;

  /// The width the Widget should get
  final double? width;

  /// How the Widget should be positioned within its parent
  final GlasspWidgetFit fit;

  /// Creates a GlasspWidget bound by the given height and width
  const GlasspWidget({
    Key? key,
    required this.height,
    this.width,
    this.fit = GlasspWidgetFit.fitContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null != width) {
      return SizedBox(
        height: height,
        width: width,
        child: _widget,
      );
    } else if (fit == GlasspWidgetFit.fitContent) {
      return SizedBox(
        height: height,
        width: _textSize.width + 2 * _cutLength,
        child: _widget,
      );
    } else if (fit == GlasspWidgetFit.fillParent) {
      return Container(
        height: height,
        width: double.infinity,
        child: _widget,
      );
    } else {
      // wtf did you do to get here?!?
      throw Exception("You should never see this message");
    }
  }

  /// Getting the size of the cut depending on the height of the widget.
  /// The ancle of the cut should always be 45°
  double get _cutLength => height / tan(45);

  Widget get _widget => ClipPath(
        clipper: ParallelogramClipper(_cutLength, Edge.right),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.2),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: Center(
              child: Text(
                _textContent,
                textAlign: TextAlign.center,
                style: _textStyle,
                softWrap: false,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      );

  TextStyle get _textStyle => TextStyle(fontSize: 24);

  String get _textContent => "GLASSP";

  Size get _textSize {
    final textPainter = TextPainter(
        text: TextSpan(text: _textContent, style: _textStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

/// How the GlasspWidget should fit itself inside the parent
enum GlasspWidgetFit {
  /// fill the full width of the parent
  fillParent,

  /// fit the width to match the content
  fitContent,
}

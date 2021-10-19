import 'package:flutter/widgets.dart';

/// The clipper that creates a Parallelogram Shape
class ParallelogramClipper extends CustomClipper<Path> {
  /// Creates a Parallelogram Shape that clips the [cutLength] at both ends in
  /// direction defined by [edge]
  ParallelogramClipper(this.cutLength, this.edge);

  /// How much to cut
  final double cutLength;

  /// Which direction to cut
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.top:
        return _getTopPath(size);
      case Edge.right:
        return _getRightPath(size);
      case Edge.bottom:
        return _getBottomPath(size);
      case Edge.left:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - cutLength);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, cutLength);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.moveTo(cutLength, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width - cutLength, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.moveTo(0.0, cutLength);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - cutLength);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.lineTo(size.width - cutLength, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(cutLength, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    final oldie = oldClipper as ParallelogramClipper;
    return cutLength != oldie.cutLength;
  }
}

/// which direction to use
enum Edge {
  /// The horizontal edges is flowing from left-top to right-bottom
  top,

  /// The vertical edges of the Parallelogram is rotated to the right: /=/
  right,

  /// The horizontal edges is flowing from left-top to right-bottom
  bottom,

  /// The vertical edges of the Parallelogram is rotated to the left: \=\
  left,
}

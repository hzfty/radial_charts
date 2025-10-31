import 'package:flutter/material.dart';

/// Custom painter for drawing a solid donut ring with a single color
///
/// This painter is used when the chart contains only one segment.
/// It draws a complete ring (360 degrees) with a hole in the center.
///
/// Example:
/// ```dart
/// CustomPaint(
///   size: Size(270, 270),
///   painter: SingleItemDonutPainter(
///     color: Colors.blue,
///     outerRadius: 135,
///     innerRadius: 100,
///   ),
/// )
/// ```
class SingleItemDonutPainter extends CustomPainter {
  /// Color of the donut ring
  final Color color;

  /// Outer radius of the ring
  final double outerRadius;

  /// Inner radius of the ring (creates the center hole)
  final double innerRadius;

  const SingleItemDonutPainter({
    required this.color,
    required this.outerRadius,
    required this.innerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Create paint for filling
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Create path for the donut shape
    final path = Path();

    // Add outer circle
    path.addOval(Rect.fromCircle(center: center, radius: outerRadius));

    // Add inner circle (creates the hole)
    path.addOval(Rect.fromCircle(center: center, radius: innerRadius));

    // Set fill rule to create the hole
    path.fillType = PathFillType.evenOdd;

    // Draw the donut
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SingleItemDonutPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.outerRadius != outerRadius ||
        oldDelegate.innerRadius != innerRadius;
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/donut_segment_data.dart';

/// Custom painter for drawing donut chart segments with rounded edges
///
/// This painter creates a donut chart where segments have smooth, rounded
/// connections using Bezier curves. The rendering is done in two passes:
/// 1. Draw all segments with convex (outward) rounded caps
/// 2. Fill the concave (inward) gaps with the next segment's color
///
/// This two-pass approach creates seamless, rounded transitions between segments.
///
/// Example:
/// ```dart
/// CustomPaint(
///   size: Size(270, 270),
///   painter: RoundedDonutPainter(
///     data: segments,
///     outerRadius: 135,
///     innerRadius: 100,
///     startAngle: -math.pi / 2,
///     sortSegmentsById: true,
///   ),
/// )
/// ```
class RoundedDonutPainter extends CustomPainter {
  /// Segment data to display in the chart
  final List<DonutSegmentData> data;

  /// Outer radius of the donut ring
  final double outerRadius;

  /// Inner radius of the donut ring
  final double innerRadius;

  /// Starting angle in radians (default: -π/2 for top)
  final double startAngle;

  /// Whether to sort segments by ID before rendering
  final bool sortSegmentsById;

  /// Thickness of the ring (outerRadius - innerRadius)
  late final double strokeWidth;

  /// Middle radius used for drawing (average of outer and inner)
  late final double drawRadius;

  RoundedDonutPainter({
    required this.data,
    required this.outerRadius,
    required this.innerRadius,
    this.startAngle = -1.5707963267948966, // -π/2
    this.sortSegmentsById = true,
  }) {
    strokeWidth = outerRadius - innerRadius;
    drawRadius = (outerRadius + innerRadius) / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Sort data if configured
    final segments = List<DonutSegmentData>.from(data);
    if (sortSegmentsById) {
      segments.sort((a, b) => a.id.compareTo(b.id));
    }

    // Filter out zero values
    final validSegments =
        segments.where((segment) => segment.value > 0).toList();

    if (validSegments.isEmpty) return;

    final totalValue =
        validSegments.fold<double>(0, (sum, item) => sum + item.value);

    if (totalValue == 0) return;

    double currentAngle = startAngle;

    // PASS 1: Draw all segments with convex rounded caps
    for (int i = 0; i < validSegments.length; i++) {
      final segment = validSegments[i];
      final segmentAngle = (segment.value / totalValue) * 2 * math.pi;

      _drawSegmentWithRoundedCap(
        canvas,
        center,
        currentAngle,
        segmentAngle,
        segment.color,
      );

      currentAngle += segmentAngle;
    }

    // PASS 2: Fill concave gaps with next segment's color
    currentAngle = startAngle;
    for (int i = 0; i < validSegments.length; i++) {
      final segment = validSegments[i];
      final segmentAngle = (segment.value / totalValue) * 2 * math.pi;

      // Get next segment's color (wrapping around)
      final nextIndex = (i + 1) % validSegments.length;
      final nextColor = validSegments[nextIndex].color;

      _fillConcaveCap(
        canvas,
        center,
        currentAngle + segmentAngle, // End of current segment
        nextColor,
      );

      currentAngle += segmentAngle;
    }
  }

  /// Draw a segment with a rounded cap at the end
  void _drawSegmentWithRoundedCap(
    Canvas canvas,
    Offset center,
    double startAngle,
    double segmentAngle,
    Color color,
  ) {
    // Create custom path for the segment
    final path = Path();

    // Get key points
    final innerStart = _getPointOnCircle(center, innerRadius, startAngle);
    final outerStart = _getPointOnCircle(center, outerRadius, startAngle);
    final innerEnd =
        _getPointOnCircle(center, innerRadius, startAngle + segmentAngle);
    final outerEnd =
        _getPointOnCircle(center, outerRadius, startAngle + segmentAngle);

    // Start at inner point
    path.moveTo(innerStart.dx, innerStart.dy);

    // Straight line to outer start (no rounding at start)
    path.lineTo(outerStart.dx, outerStart.dy);

    // Arc along outer circle
    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    path.arcTo(outerRect, startAngle, segmentAngle, false);

    // KEY FEATURE: Rounded connection at the end
    _addRoundedConnection(path, outerEnd, innerEnd, strokeWidth / 8);

    // Arc along inner circle (reverse direction)
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);
    path.arcTo(innerRect, startAngle + segmentAngle, -segmentAngle, false);

    // Close the path
    path.close();

    // Draw filled segment
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  /// Add a rounded connection between two points using Bezier curves
  void _addRoundedConnection(Path path, Offset from, Offset to, double radius) {
    // Enhance radius for more pronounced rounding (4x multiplier)
    final enhancedRadius = radius * 4;

    // Calculate direction and perpendicular vectors
    final direction = (to - from).normalize();
    final perpendicular = Offset(-direction.dy, direction.dx);

    // Control points for cubic Bezier curve
    final control1 = from + perpendicular * enhancedRadius;
    final control2 = to + perpendicular * enhancedRadius;

    // Add smooth cubic Bezier curve for rounded edge
    path.cubicTo(
      control1.dx,
      control1.dy,
      control2.dx,
      control2.dy,
      to.dx,
      to.dy,
    );
  }

  /// Fill the concave gap with the next segment's color
  void _fillConcaveCap(
    Canvas canvas,
    Offset center,
    double angle,
    Color fillColor,
  ) {
    // Get points at the end of the segment
    final innerPoint = _getPointOnCircle(center, innerRadius, angle);
    final outerPoint = _getPointOnCircle(center, outerRadius, angle);

    // Create path for filling the concave area
    final fillPath = Path();

    // Start at outer point
    fillPath.moveTo(outerPoint.dx, outerPoint.dy);

    // Create convex curve (inverse of concave)
    final direction = (innerPoint - outerPoint).normalize();
    final perpendicular = Offset(-direction.dy, direction.dx);

    // Enhanced radius for pronounced rounding (4x multiplier)
    final enhancedRadius = (strokeWidth / 8) * 4;

    // Control points for convex curve
    final control1 = outerPoint + perpendicular * enhancedRadius;
    final control2 = innerPoint + perpendicular * enhancedRadius;

    // Convex curve to inner point
    fillPath.cubicTo(
      control1.dx,
      control1.dy,
      control2.dx,
      control2.dy,
      innerPoint.dx,
      innerPoint.dy,
    );

    // Straight line back to outer point
    fillPath.lineTo(outerPoint.dx, outerPoint.dy);
    fillPath.close();

    // Paint for filling
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // Fill the concave area
    canvas.drawPath(fillPath, fillPaint);
  }

  /// Get a point on a circle at a specific angle
  Offset _getPointOnCircle(Offset center, double radius, double angle) {
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  @override
  bool shouldRepaint(covariant RoundedDonutPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.outerRadius != outerRadius ||
        oldDelegate.innerRadius != innerRadius ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sortSegmentsById != sortSegmentsById;
  }
}

/// Extension for normalizing offset vectors
extension _OffsetExtension on Offset {
  /// Normalize the vector to unit length
  Offset normalize() {
    final length = distance;
    if (length == 0) return Offset.zero;
    return this / length;
  }
}

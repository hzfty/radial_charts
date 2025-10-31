import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/category_data.dart';
import '../models/chart_config.dart';

/// Custom painter for drawing the radial rating chart
///
/// This painter draws:
/// - Concentric circles for the rating grid
/// - Radial lines dividing categories
/// - Filled segments representing each category's rating
class RadialChartPainter extends CustomPainter {
  /// List of category data to display
  final List<CategoryData> data;

  /// Configuration for chart appearance
  final ChartConfig config;

  RadialChartPainter({
    required this.data,
    required this.config,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Filter and optionally sort data
    final validData = _prepareData();

    // Draw the grid (concentric circles and radial lines)
    _drawGrid(canvas, center, radius, validData);

    // Draw filled segments if there's data
    if (validData.isNotEmpty) {
      _drawSegments(canvas, center, radius, validData);
    }
  }

  /// Prepare data: filter valid entries and optionally sort
  List<CategoryData> _prepareData() {
    // Filter data with ratings at or above minimum
    var validData =
        data.where((item) => item.rating >= config.minRating).toList();

    // Sort by category ID if configured
    if (config.sortCategoriesById) {
      validData.sort((a, b) => a.id.compareTo(b.id));
    }

    return validData;
  }

  /// Draw the grid (concentric circles and radial lines)
  void _drawGrid(Canvas canvas, Offset center, double radius,
      List<CategoryData> validData) {
    final gridPaint = Paint()
      ..color = config.gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.gridStrokeWidth;

    // Draw concentric circles
    for (int i = 1; i <= config.gridLevels; i++) {
      final levelRadius = radius * i / config.gridLevels;
      canvas.drawCircle(center, levelRadius, gridPaint);
    }

    // Draw radial lines (one for each category)
    // Only draw division lines when there are 2 or more categories
    if (validData.length > 1) {
      final angleStep = 2 * math.pi / validData.length;

      for (int i = 0; i < validData.length; i++) {
        final angle = config.startAngle + (i * angleStep);
        final endPoint = Offset(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        );
        canvas.drawLine(center, endPoint, gridPaint);
      }
    }
  }

  /// Draw filled segments for each category
  void _drawSegments(Canvas canvas, Offset center, double radius,
      List<CategoryData> validData) {
    final angleStep = 2 * math.pi / validData.length;

    for (int i = 0; i < validData.length; i++) {
      final item = validData[i];

      // Calculate segment radius based on rating
      final normalizedRating = item.rating / config.maxRating;
      final segmentRadius = radius * normalizedRating;

      // Get category color
      final segmentColor =
          item.category.color.withValues(alpha: config.segmentOpacity);

      // Paint for filled segment
      final segmentPaint = Paint()
        ..color = segmentColor
        ..style = PaintingStyle.fill;

      // Special case: single category = full circle
      if (validData.length == 1) {
        canvas.drawCircle(center, segmentRadius, segmentPaint);
      } else {
        // Multiple categories: draw pie segments
        final startAngle = config.startAngle + (i * angleStep);
        final sweepAngle = angleStep;

        // Create path for segment
        final path = Path()
          ..moveTo(center.dx, center.dy)
          ..arcTo(
            Rect.fromCircle(center: center, radius: segmentRadius),
            startAngle,
            sweepAngle,
            false,
          )
          ..close();

        canvas.drawPath(path, segmentPaint);

        // Draw border if enabled
        if (config.showSegmentBorders) {
          final borderPaint = Paint()
            ..color =
                config.segmentBorderColor ?? segmentColor.withValues(alpha: 0.8)
            ..style = PaintingStyle.stroke
            ..strokeWidth = config.segmentBorderWidth;

          canvas.drawPath(path, borderPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant RadialChartPainter oldDelegate) {
    // Repaint if data or config changed
    return oldDelegate.data != data || oldDelegate.config != config;
  }
}

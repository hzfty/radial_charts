import 'package:flutter/material.dart';

/// Configuration for the radial rating chart appearance and behavior
///
/// Controls visual aspects like colors, sizes, grid levels, and more.
///
/// Example:
/// ```dart
/// final config = ChartConfig(
///   size: 300,
///   maxRating: 10,
///   gridLevels: 10,
///   gridColor: Colors.grey.withOpacity(0.3),
/// );
/// ```
class ChartConfig {
  /// Size of the chart (width and height)
  final double size;

  /// Maximum rating value (default: 10)
  final int maxRating;

  /// Minimum rating value (default: 1)
  final int minRating;

  /// Number of concentric circles in the grid (default: 10)
  final int gridLevels;

  /// Color of the grid lines
  final Color gridColor;

  /// Width of the grid lines
  final double gridStrokeWidth;

  /// Opacity of category segments (0.0 - 1.0)
  final double segmentOpacity;

  /// Whether to show segment borders
  final bool showSegmentBorders;

  /// Color of segment borders (if enabled)
  final Color? segmentBorderColor;

  /// Width of segment borders (if enabled)
  final double segmentBorderWidth;

  /// Start angle in radians (default: -π/2, which starts at top)
  final double startAngle;

  /// Whether categories should be sorted by ID for consistent positioning
  final bool sortCategoriesById;

  const ChartConfig({
    this.size = 280.0,
    this.maxRating = 10,
    this.minRating = 1,
    this.gridLevels = 10,
    this.gridColor = const Color(0x4D000000), // 30% black
    this.gridStrokeWidth = 1.0,
    this.segmentOpacity = 0.7,
    this.showSegmentBorders = true,
    this.segmentBorderColor,
    this.segmentBorderWidth = 0.5,
    this.startAngle = -1.5707963267948966, // -π/2
    this.sortCategoriesById = true,
  });

  /// Create a copy with modified properties
  ChartConfig copyWith({
    double? size,
    int? maxRating,
    int? minRating,
    int? gridLevels,
    Color? gridColor,
    double? gridStrokeWidth,
    double? segmentOpacity,
    bool? showSegmentBorders,
    Color? segmentBorderColor,
    double? segmentBorderWidth,
    double? startAngle,
    bool? sortCategoriesById,
  }) {
    return ChartConfig(
      size: size ?? this.size,
      maxRating: maxRating ?? this.maxRating,
      minRating: minRating ?? this.minRating,
      gridLevels: gridLevels ?? this.gridLevels,
      gridColor: gridColor ?? this.gridColor,
      gridStrokeWidth: gridStrokeWidth ?? this.gridStrokeWidth,
      segmentOpacity: segmentOpacity ?? this.segmentOpacity,
      showSegmentBorders: showSegmentBorders ?? this.showSegmentBorders,
      segmentBorderColor: segmentBorderColor ?? this.segmentBorderColor,
      segmentBorderWidth: segmentBorderWidth ?? this.segmentBorderWidth,
      startAngle: startAngle ?? this.startAngle,
      sortCategoriesById: sortCategoriesById ?? this.sortCategoriesById,
    );
  }

  @override
  String toString() => 'ChartConfig(size: $size, maxRating: $maxRating, gridLevels: $gridLevels)';
}

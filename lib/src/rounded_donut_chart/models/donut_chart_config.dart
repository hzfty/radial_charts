import 'package:flutter/material.dart';

/// Configuration for the rounded donut chart appearance and behavior
///
/// Controls visual aspects like sizes, radii, colors, and sorting.
///
/// Example:
/// ```dart
/// final config = DonutChartConfig(
///   size: 270,
///   outerRadius: 135,
///   innerRadius: 100,
///   emptyStateColor: Colors.grey.withOpacity(0.3),
/// );
/// ```
class DonutChartConfig {
  /// Overall size of the chart (width and height)
  final double size;

  /// Outer radius of the donut ring
  final double outerRadius;

  /// Inner radius of the donut ring (creates the hole in the center)
  final double innerRadius;

  /// Start angle in radians (default: -π/2, which starts at top)
  final double startAngle;

  /// Whether segments should be sorted by ID for consistent positioning
  final bool sortSegmentsById;

  /// Background color for empty state (when no data)
  final Color emptyStateColor;

  /// Border color for empty state
  final Color emptyStateBorderColor;

  /// Border width for empty state
  final double emptyStateBorderWidth;

  const DonutChartConfig({
    this.size = 270.0,
    this.outerRadius = 135.0,
    this.innerRadius = 100.0,
    this.startAngle = -1.5707963267948966, // -π/2
    this.sortSegmentsById = true,
    this.emptyStateColor = const Color(0x4DBCB5C0),
    this.emptyStateBorderColor = const Color(0xFFE0E0E0),
    this.emptyStateBorderWidth = 2.0,
  });

  /// Create a copy with modified properties
  DonutChartConfig copyWith({
    double? size,
    double? outerRadius,
    double? innerRadius,
    double? startAngle,
    bool? sortSegmentsById,
    Color? emptyStateColor,
    Color? emptyStateBorderColor,
    double? emptyStateBorderWidth,
  }) {
    return DonutChartConfig(
      size: size ?? this.size,
      outerRadius: outerRadius ?? this.outerRadius,
      innerRadius: innerRadius ?? this.innerRadius,
      startAngle: startAngle ?? this.startAngle,
      sortSegmentsById: sortSegmentsById ?? this.sortSegmentsById,
      emptyStateColor: emptyStateColor ?? this.emptyStateColor,
      emptyStateBorderColor:
          emptyStateBorderColor ?? this.emptyStateBorderColor,
      emptyStateBorderWidth:
          emptyStateBorderWidth ?? this.emptyStateBorderWidth,
    );
  }

  /// Get the stroke width (thickness of the donut ring)
  double get strokeWidth => outerRadius - innerRadius;

  /// Get the draw radius (middle of the ring)
  double get drawRadius => (outerRadius + innerRadius) / 2;

  @override
  String toString() =>
      'DonutChartConfig(size: $size, outerRadius: $outerRadius, innerRadius: $innerRadius)';
}

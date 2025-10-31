import 'package:flutter/material.dart';

/// Represents a single item in a chart legend
///
/// This is a common data structure used by both RadialRatingChart
/// and RoundedDonutChart for their legend displays.
///
/// Example:
/// ```dart
/// LegendItem(
///   id: '1',
///   label: 'Health',
///   color: Colors.green,
///   emoji: '🏃',
///   value: '8',
/// )
/// ```
class LegendItem {
  /// Unique identifier for this legend item
  final String id;

  /// Display label/name
  final String label;

  /// Color of the indicator
  final Color color;

  /// Optional emoji to display before the label
  final String? emoji;

  /// Optional value to display inside the indicator (for rectangular styles)
  final String? value;

  const LegendItem({
    required this.id,
    required this.label,
    required this.color,
    this.emoji,
    this.value,
  });
}

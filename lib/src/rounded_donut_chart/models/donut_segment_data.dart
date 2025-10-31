import 'package:flutter/material.dart';

/// Represents a segment (slice) in the rounded donut chart
///
/// Each segment has a unique identifier, numerical value, color, and label.
/// Segments are the colored portions that make up the donut chart.
///
/// Example:
/// ```dart
/// final segment = DonutSegmentData(
///   id: 'completed',
///   value: 45,
///   color: Colors.green,
///   label: 'Completed Tasks',
///   description: 'Tasks that have been finished',
///   metadata: {'status': 1, 'icon': '✓'},
/// );
/// ```
class DonutSegmentData {
  /// Unique identifier for the segment (used for sorting and comparison)
  final String id;

  /// Numerical value of the segment (used to calculate segment size)
  final double value;

  /// Color of the segment in the chart
  final Color color;

  /// Display label shown in the legend
  final String label;

  /// Optional emoji displayed in the legend
  final String? emoji;

  /// Optional description for additional context
  final String? description;

  /// Optional metadata for storing additional data (status codes, icons, etc.)
  final Map<String, dynamic>? metadata;

  const DonutSegmentData({
    required this.id,
    required this.value,
    required this.color,
    required this.label,
    this.emoji,
    this.description,
    this.metadata,
  });

  /// Create a copy with modified properties
  DonutSegmentData copyWith({
    String? id,
    double? value,
    Color? color,
    String? label,
    String? emoji,
    String? description,
    Map<String, dynamic>? metadata,
  }) {
    return DonutSegmentData(
      id: id ?? this.id,
      value: value ?? this.value,
      color: color ?? this.color,
      label: label ?? this.label,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonutSegmentData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'DonutSegmentData(id: $id, value: $value, label: $label, color: $color)';
}

import 'package:flutter/material.dart';

/// Represents a category in the radial rating chart
///
/// Each category has a unique identifier, display name, color, and optional icon/emoji.
/// Categories are the segments that make up the radial chart.
///
/// Example:
/// ```dart
/// final category = ChartCategory(
///   id: 'health',
///   name: 'Health',
///   color: Colors.green,
///   emoji: '🏃',
/// );
/// ```
class ChartCategory {
  /// Unique identifier for the category
  final String id;

  /// Display name shown in the UI
  final String name;

  /// Color used for this category's segment in the chart
  final Color color;

  /// Optional emoji/icon to represent the category
  final String? emoji;

  /// Optional description for the category
  final String? description;

  const ChartCategory({
    required this.id,
    required this.name,
    required this.color,
    this.emoji,
    this.description,
  });

  /// Create a copy with modified properties
  ChartCategory copyWith({
    String? id,
    String? name,
    Color? color,
    String? emoji,
    String? description,
  }) {
    return ChartCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ChartCategory(id: $id, name: $name, color: $color)';
}

/// Predefined categories for common use cases
class DefaultCategories {
  /// Life balance categories (based on the original Balance Wheel)
  static const List<ChartCategory> lifeBalance = [
    ChartCategory(
      id: 'personal_growth',
      name: 'Personal Growth',
      color: Color(0xFFE53838),
      emoji: '🤩',
    ),
    ChartCategory(
      id: 'career',
      name: 'Career',
      color: Color(0xFF13E1AA),
      emoji: '💼',
    ),
    ChartCategory(
      id: 'relationships',
      name: 'Relationships',
      color: Color(0xFFFFDBDB),
      emoji: '❤️',
    ),
    ChartCategory(
      id: 'social',
      name: 'Social Life',
      color: Color(0xFF98FF9D),
      emoji: '👥',
    ),
    ChartCategory(
      id: 'health',
      name: 'Health',
      color: Color(0xFFFF81BE),
      emoji: '🏃',
    ),
    ChartCategory(
      id: 'appearance',
      name: 'Appearance',
      color: Color(0xFFFFCE7B),
      emoji: '👔',
    ),
    ChartCategory(
      id: 'entertainment',
      name: 'Entertainment',
      color: Color(0xFF93B9FF),
      emoji: '🎮',
    ),
    ChartCategory(
      id: 'free_time',
      name: 'Free Time',
      color: Color(0xFFFFC107),
      emoji: '⏱️',
    ),
    ChartCategory(
      id: 'finance',
      name: 'Finance',
      color: Color(0xFFF677FF),
      emoji: '💰',
    ),
    ChartCategory(
      id: 'friendship',
      name: 'Friendship',
      color: Color(0xFFFF7474),
      emoji: '👫',
    ),
    ChartCategory(
      id: 'home',
      name: 'Home',
      color: Color(0xFFA5F0E1),
      emoji: '🏠',
    ),
  ];

  /// Skills assessment categories
  static const List<ChartCategory> skills = [
    ChartCategory(
      id: 'technical',
      name: 'Technical Skills',
      color: Color(0xFF2196F3),
      emoji: '💻',
    ),
    ChartCategory(
      id: 'communication',
      name: 'Communication',
      color: Color(0xFF4CAF50),
      emoji: '💬',
    ),
    ChartCategory(
      id: 'leadership',
      name: 'Leadership',
      color: Color(0xFFFF9800),
      emoji: '👑',
    ),
    ChartCategory(
      id: 'creativity',
      name: 'Creativity',
      color: Color(0xFF9C27B0),
      emoji: '🎨',
    ),
    ChartCategory(
      id: 'problem_solving',
      name: 'Problem Solving',
      color: Color(0xFFF44336),
      emoji: '🧩',
    ),
  ];

  /// Product features ratings
  static const List<ChartCategory> productFeatures = [
    ChartCategory(
      id: 'usability',
      name: 'Usability',
      color: Color(0xFF00BCD4),
      emoji: '👆',
    ),
    ChartCategory(
      id: 'performance',
      name: 'Performance',
      color: Color(0xFF8BC34A),
      emoji: '⚡',
    ),
    ChartCategory(
      id: 'design',
      name: 'Design',
      color: Color(0xFFE91E63),
      emoji: '🎨',
    ),
    ChartCategory(
      id: 'features',
      name: 'Features',
      color: Color(0xFF673AB7),
      emoji: '⭐',
    ),
    ChartCategory(
      id: 'support',
      name: 'Support',
      color: Color(0xFFFF5722),
      emoji: '🆘',
    ),
  ];
}

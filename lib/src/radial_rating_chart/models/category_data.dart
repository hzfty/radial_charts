import 'chart_category.dart';

/// Represents a category with its rating value
///
/// This combines a [ChartCategory] with a numerical rating, typically from 1-10.
/// Used to build the radial rating chart visualization.
///
/// Example:
/// ```dart
/// final data = CategoryData(
///   category: ChartCategory(
///     id: 'health',
///     name: 'Health',
///     color: Colors.green,
///   ),
///   rating: 8,
/// );
/// ```
class CategoryData {
  /// The category being rated
  final ChartCategory category;

  /// The rating value (typically 1-10)
  final double rating;

  const CategoryData({
    required this.category,
    required this.rating,
  });

  /// Create a copy with modified properties
  CategoryData copyWith({
    ChartCategory? category,
    double? rating,
  }) {
    return CategoryData(
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  /// Convenience getter for category id
  String get id => category.id;

  /// Convenience getter for category name
  String get name => category.name;

  /// Convenience getter for category color
  /// ignore: library_private_types_in_public_api
  dynamic get color => category.color;

  /// Convenience getter for category emoji
  String? get emoji => category.emoji;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryData &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          rating == other.rating;

  @override
  int get hashCode => category.hashCode ^ rating.hashCode;

  @override
  String toString() => 'CategoryData(category: ${category.name}, rating: $rating)';
}

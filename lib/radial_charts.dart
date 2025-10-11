/// A collection of customizable radial chart widgets for Flutter
///
/// Display ratings and data across multiple categories with variable radius segments.
/// Perfect for visualizing assessments, reviews, and multi-dimensional data.
///
/// ## Features
///
/// - **Variable Radius Segments**: Each category's segment radius represents its rating
/// - **Customizable Appearance**: Colors, grid levels, opacity, and more
/// - **Predefined Categories**: Life balance, skills, product features
/// - **Legend Support**: Optional legend with customizable layout
/// - **Zero Dependencies**: Pure Flutter implementation
/// - **Highly Configurable**: Extensive configuration options
///
/// ## Usage
///
/// ```dart
/// import 'package:radial_charts/radial_charts.dart';
///
/// RadialRatingChart(
///   data: [
///     CategoryData(
///       category: ChartCategory(
///         id: 'health',
///         name: 'Health',
///         color: Colors.green,
///       ),
///       rating: 8,
///     ),
///     CategoryData(
///       category: ChartCategory(
///         id: 'career',
///         name: 'Career',
///         color: Colors.blue,
///       ),
///       rating: 6,
///     ),
///   ],
///   config: ChartConfig(size: 300),
///   showLegend: true,
/// )
/// ```
library;

// Radial Rating Chart
export 'src/radial_rating_chart/models/chart_category.dart';
export 'src/radial_rating_chart/models/category_data.dart';
export 'src/radial_rating_chart/models/chart_config.dart';
export 'src/radial_rating_chart/widgets/radial_rating_chart.dart';
export 'src/radial_rating_chart/painters/radial_chart_painter.dart';

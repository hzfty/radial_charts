import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/category_data.dart';
import '../models/chart_config.dart';
import '../painters/radial_chart_painter.dart';

/// Main widget for displaying a radial rating chart
///
/// This widget displays a circular chart where each category is represented
/// by a segment (pie slice) with a radius proportional to its rating value.
///
/// Example:
/// ```dart
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
///     // more categories...
///   ],
///   config: ChartConfig(size: 300),
/// )
/// ```
class RadialRatingChart extends StatelessWidget {
  /// List of category data to display
  final List<CategoryData> data;

  /// Configuration for chart appearance (optional)
  final ChartConfig? config;

  /// Whether to show a legend below the chart
  final bool showLegend;

  /// Number of columns for the legend (default: 2)
  final int legendColumns;

  /// Spacing between legend items
  final double legendSpacing;

  /// Size of the color indicator in legend
  final double legendIndicatorSize;

  /// Text style for legend labels
  final TextStyle? legendTextStyle;

  const RadialRatingChart({
    super.key,
    required this.data,
    this.config,
    this.showLegend = false,
    this.legendColumns = 2,
    this.legendSpacing = 8.0,
    this.legendIndicatorSize = 16.0,
    this.legendTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final chartConfig = config ?? const ChartConfig();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The chart itself
        Center(
          child: SizedBox(
            width: chartConfig.size,
            height: chartConfig.size,
            child: CustomPaint(
              painter: RadialChartPainter(
                data: data,
                config: chartConfig,
              ),
            ),
          ),
        ),

        // Optional legend
        if (showLegend && data.isNotEmpty) ...[
          SizedBox(height: legendSpacing * 2),
          _buildLegend(context),
        ],
      ],
    );
  }

  /// Build the legend widget
  Widget _buildLegend(BuildContext context) {
    // Filter valid data (same as painter does)
    final validData = data
        .where((item) => item.rating > (config?.minRating ?? 1))
        .toList();

    if (validData.isEmpty) return const SizedBox.shrink();

    // Sort if configured
    if (config?.sortCategoriesById ?? true) {
      validData.sort((a, b) => a.id.compareTo(b.id));
    }

    // Calculate items per column
    final itemsPerColumn = (validData.length / legendColumns).ceil();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(legendColumns, (columnIndex) {
        final startIndex = columnIndex * itemsPerColumn;
        final endIndex = math.min(startIndex + itemsPerColumn, validData.length);

        if (startIndex >= validData.length) {
          return const Expanded(child: SizedBox.shrink());
        }

        final columnItems = validData.sublist(startIndex, endIndex);

        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnItems.map((item) => _buildLegendItem(item)).toList(),
          ),
        );
      }),
    );
  }

  /// Build a single legend item
  Widget _buildLegendItem(CategoryData item) {
    return Padding(
      padding: EdgeInsets.only(bottom: legendSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color indicator
          Container(
            width: legendIndicatorSize,
            height: legendIndicatorSize,
            decoration: BoxDecoration(
              color: item.category.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: legendSpacing),
          // Category name
          Expanded(
            child: Text(
              item.category.name,
              style: legendTextStyle ?? const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

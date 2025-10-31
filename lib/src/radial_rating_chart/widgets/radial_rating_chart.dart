import 'package:flutter/material.dart';
import '../models/category_data.dart';
import '../models/chart_config.dart';
import '../painters/radial_chart_painter.dart';
import '../../common/models/legend_style.dart';
import '../../common/models/legend_item.dart';
import '../../common/widgets/unified_legend.dart';

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

  /// Style of the legend indicator (circle, rectangle, or roundedRectangle)
  final LegendStyle legendStyle;

  /// Spacing between legend items
  final double legendSpacing;

  /// Size of the color indicator in legend
  final double legendIndicatorSize;

  /// Text style for legend labels
  final TextStyle? legendTextStyle;

  /// Whether to show rating values inside legend indicators (for rectangular styles)
  final bool showRatingInLegend;

  /// Text style for rating values inside legend indicators
  final TextStyle? legendRatingStyle;

  const RadialRatingChart({
    super.key,
    required this.data,
    this.config,
    this.showLegend = false,
    this.legendColumns = 2,
    this.legendStyle = LegendStyle.circle,
    this.legendSpacing = 8.0,
    this.legendIndicatorSize = 16.0,
    this.legendTextStyle,
    this.showRatingInLegend = false,
    this.legendRatingStyle,
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
          SizedBox(height: legendSpacing * 3),
          _buildLegend(),
        ],
      ],
    );
  }

  /// Build the legend widget using UnifiedLegend
  Widget _buildLegend() {
    // Filter valid data (same as painter does)
    final validData =
        data.where((item) => item.rating >= (config?.minRating ?? 0)).toList();

    if (validData.isEmpty) return const SizedBox.shrink();

    // Determine indicator size based on whether we're showing ratings
    final indicatorSize =
        showRatingInLegend && legendStyle != LegendStyle.circle
            ? const Size(33, 28)
            : Size(legendIndicatorSize, legendIndicatorSize);

    return UnifiedLegend(
      items: validData
          .map((item) => LegendItem(
                id: item.id,
                label: item.category.name,
                color: item.category.color,
                emoji: item.category.emoji,
                value:
                    showRatingInLegend ? item.rating.toInt().toString() : null,
              ))
          .toList(),
      style: legendStyle,
      showValueInIndicator: showRatingInLegend,
      columns: legendColumns,
      indicatorSize: indicatorSize,
      spacing: legendSpacing,
      textStyle: legendTextStyle,
      valueStyle: legendRatingStyle,
      sortById: config?.sortCategoriesById ?? true,
    );
  }
}

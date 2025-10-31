import 'package:flutter/material.dart';
import '../models/donut_segment_data.dart';
import '../models/donut_chart_config.dart';
import '../../common/models/legend_style.dart';
import '../../common/models/legend_item.dart';
import '../../common/widgets/unified_legend.dart';
import '../painters/rounded_donut_painter.dart';
import '../painters/single_item_donut_painter.dart';

/// Main widget for displaying a rounded donut chart
///
/// This widget displays a donut chart where segments have smooth, rounded edges
/// created with Bezier curves. It supports center text, customizable legend,
/// and handles empty and single-segment states automatically.
///
/// Example:
/// ```dart
/// RoundedDonutChart(
///   data: [
///     DonutSegmentData(
///       id: 'completed',
///       value: 45,
///       color: Colors.green,
///       label: 'Completed',
///     ),
///     DonutSegmentData(
///       id: 'pending',
///       value: 30,
///       color: Colors.orange,
///       label: 'Pending',
///     ),
///   ],
///   config: DonutChartConfig(size: 270),
///   showCenterText: true,
///   centerTextBuilder: (total) => '${total.toInt()}',
///   showLegend: true,
///   legendStyle: LegendStyle.roundedRectangle,
/// )
/// ```
class RoundedDonutChart extends StatelessWidget {
  /// Segment data to display in the chart
  final List<DonutSegmentData> data;

  /// Configuration for chart appearance (optional)
  final DonutChartConfig? config;

  // Center Text Configuration
  /// Static text to display in the center (takes precedence over centerTextBuilder)
  final String? centerText;

  /// Function to generate center text from total value
  final String Function(double total)? centerTextBuilder;

  /// Text style for the center text
  final TextStyle? centerTextStyle;

  /// Whether to show center text
  final bool showCenterText;

  // Legend Configuration
  /// Whether to show a legend below the chart
  final bool showLegend;

  /// Visual style of legend indicators
  final LegendStyle legendStyle;

  /// Number of columns for the legend
  final int legendColumns;

  /// Size of legend color indicators
  final Size legendIndicatorSize;

  /// Whether to show count values inside legend indicators
  final bool showCountInLegend;

  /// Spacing between legend items
  final double legendSpacing;

  /// Text style for legend labels
  final TextStyle? legendTextStyle;

  /// Text style for legend count numbers
  final TextStyle? legendCountStyle;

  const RoundedDonutChart({
    super.key,
    required this.data,
    this.config,
    this.centerText,
    this.centerTextBuilder,
    this.centerTextStyle,
    this.showCenterText = true,
    this.showLegend = false,
    this.legendStyle = LegendStyle.roundedRectangle,
    this.legendColumns = 2,
    this.legendIndicatorSize = const Size(33, 28),
    this.showCountInLegend = true,
    this.legendSpacing = 8.0,
    this.legendTextStyle,
    this.legendCountStyle,
  });

  @override
  Widget build(BuildContext context) {
    final chartConfig = config ?? const DonutChartConfig();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The chart with center text
        _buildChart(chartConfig),

        // Optional legend
        if (showLegend && data.isNotEmpty) ...[
          SizedBox(height: legendSpacing * 3),
          UnifiedLegend(
            items: data.map((segment) => LegendItem(
              id: segment.id,
              label: segment.label,
              color: segment.color,
              emoji: segment.emoji,
              value: showCountInLegend ? segment.value.toInt().toString() : null,
            )).toList(),
            style: legendStyle,
            showValueInIndicator: showCountInLegend,
            columns: legendColumns,
            indicatorSize: legendIndicatorSize,
            spacing: legendSpacing,
            textStyle: legendTextStyle,
            valueStyle: legendCountStyle,
            sortById: chartConfig.sortSegmentsById,
          ),
        ],
      ],
    );
  }

  /// Build the chart with center text overlay
  Widget _buildChart(DonutChartConfig chartConfig) {
    return SizedBox(
      width: chartConfig.size,
      height: chartConfig.size,
      child: Stack(
        children: [
          // The donut chart
          Center(
            child: _buildDonutChart(chartConfig),
          ),

          // Center text overlay
          if (showCenterText) _buildCenterText(chartConfig.innerRadius),
        ],
      ),
    );
  }

  /// Build the donut chart based on data state
  Widget _buildDonutChart(DonutChartConfig chartConfig) {
    // Filter valid segments (value > 0)
    final validSegments =
        data.where((segment) => segment.value > 0).toList();

    // Empty state
    if (validSegments.isEmpty) {
      return _buildEmptyChart(chartConfig);
    }

    // Single segment state
    if (validSegments.length == 1) {
      return _buildSingleSegmentChart(validSegments.first, chartConfig);
    }

    // Multiple segments state
    return CustomPaint(
      size: Size(chartConfig.size, chartConfig.size),
      painter: RoundedDonutPainter(
        data: validSegments,
        outerRadius: chartConfig.outerRadius,
        innerRadius: chartConfig.innerRadius,
        startAngle: chartConfig.startAngle,
        sortSegmentsById: chartConfig.sortSegmentsById,
      ),
    );
  }

  /// Build empty state chart (no data)
  Widget _buildEmptyChart(DonutChartConfig chartConfig) {
    return Container(
      width: chartConfig.size,
      height: chartConfig.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: chartConfig.emptyStateColor,
        border: Border.all(
          color: chartConfig.emptyStateBorderColor,
          width: chartConfig.emptyStateBorderWidth,
        ),
      ),
    );
  }

  /// Build single segment chart (full ring, one color)
  Widget _buildSingleSegmentChart(
    DonutSegmentData segment,
    DonutChartConfig chartConfig,
  ) {
    return CustomPaint(
      size: Size(chartConfig.size, chartConfig.size),
      painter: SingleItemDonutPainter(
        color: segment.color,
        outerRadius: chartConfig.outerRadius,
        innerRadius: chartConfig.innerRadius,
      ),
    );
  }

  /// Build center text overlay with size constraints
  Widget _buildCenterText(double innerRadius) {
    final totalValue = data.fold<double>(0, (sum, item) => sum + item.value);

    String? displayText;

    // Priority: centerText > centerTextBuilder
    if (centerText != null) {
      displayText = centerText;
    } else if (centerTextBuilder != null) {
      displayText = centerTextBuilder!(totalValue);
    }

    if (displayText == null) return const SizedBox.shrink();

    // Calculate available space: inscribed square in circle (diameter / sqrt(2) * 0.85 for padding)
    // For text to fit in a circle, it must fit in the inscribed square
    final maxSize = innerRadius * 2 / 1.414 * 0.85;

    // Get base text style
    final baseStyle = centerTextStyle ??
        const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w600,
          color: Color(0xFF757177),
        );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxSize,
          maxHeight: maxSize,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Try to fit text with scaling from base font size down to 12px
            double fontSize = baseStyle.fontSize ?? 72;
            const minFontSize = 12.0;
            const maxLines = 3;

            // Create text painter to measure text
            TextPainter textPainter;
            TextStyle currentStyle;

            do {
              currentStyle = baseStyle.copyWith(fontSize: fontSize);
              textPainter = TextPainter(
                text: TextSpan(text: displayText, style: currentStyle),
                maxLines: maxLines,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: constraints.maxWidth);

              // If text fits, use this font size
              if (textPainter.height <= constraints.maxHeight &&
                  textPainter.width <= constraints.maxWidth) {
                break;
              }

              // Reduce font size
              fontSize -= 2;
            } while (fontSize >= minFontSize);

            // Ensure we don't go below minimum
            if (fontSize < minFontSize) {
              fontSize = minFontSize;
            }

            return Text(
              displayText!,
              style: currentStyle.copyWith(fontSize: fontSize),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}

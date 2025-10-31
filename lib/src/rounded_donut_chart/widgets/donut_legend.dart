import 'package:flutter/material.dart';
import '../models/donut_segment_data.dart';
import '../../common/models/legend_style.dart';

/// Widget for displaying a legend below the donut chart
///
/// Shows all segments with their colors, labels, and optional count values.
/// Supports three visual styles: circle, rectangle, and rounded rectangle.
///
/// Example:
/// ```dart
/// DonutLegend(
///   data: segments,
///   style: LegendStyle.roundedRectangle,
///   columns: 2,
///   showCount: true,
/// )
/// ```
class DonutLegend extends StatelessWidget {
  /// Segment data to display in the legend
  final List<DonutSegmentData> data;

  /// Visual style of the color indicators
  final LegendStyle style;

  /// Number of columns for the legend layout
  final int columns;

  /// Size of the color indicator
  final Size indicatorSize;

  /// Whether to show count values inside indicators
  final bool showCount;

  /// Spacing between legend items
  final double spacing;

  /// Text style for labels
  final TextStyle? textStyle;

  /// Text style for count numbers
  final TextStyle? countStyle;

  /// Whether to sort items by ID
  final bool sortById;

  const DonutLegend({
    super.key,
    required this.data,
    this.style = LegendStyle.roundedRectangle,
    this.columns = 2,
    this.indicatorSize = const Size(33, 28),
    this.showCount = true,
    this.spacing = 8.0,
    this.textStyle,
    this.countStyle,
    this.sortById = true,
  });

  @override
  Widget build(BuildContext context) {
    // Sort data if configured
    final segments = List<DonutSegmentData>.from(data);
    if (sortById) {
      segments.sort((a, b) => a.id.compareTo(b.id));
    }

    // Build legend rows
    final List<Widget> rows = [];

    for (int i = 0; i < segments.length; i += columns) {
      final rowItems = <Widget>[];

      for (int j = 0; j < columns; j++) {
        final index = i + j;
        if (index < segments.length) {
          rowItems.add(
            Expanded(
              child: _buildLegendItem(segments[index]),
            ),
          );
        } else {
          // Empty space for incomplete rows
          rowItems.add(const Expanded(child: SizedBox()));
        }

        // Add spacing between columns (but not after last column)
        if (j < columns - 1 && index < segments.length) {
          rowItems.add(SizedBox(width: spacing * 2));
        }
      }

      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            children: rowItems,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  /// Build a single legend item with color indicator and label
  Widget _buildLegendItem(DonutSegmentData segment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Color indicator
        _buildIndicator(segment),
        SizedBox(width: spacing),
        // Label
        Expanded(
          child: Text(
            segment.label,
            style: textStyle ??
                const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF757177),
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Build the color indicator based on the selected style
  Widget _buildIndicator(DonutSegmentData segment) {
    switch (style) {
      case LegendStyle.circle:
        return _buildCircleIndicator(segment);
      case LegendStyle.rectangle:
        return _buildRectangleIndicator(segment, borderRadius: 0);
      case LegendStyle.roundedRectangle:
        return _buildRectangleIndicator(segment, borderRadius: 4);
    }
  }

  /// Build a circular color indicator
  Widget _buildCircleIndicator(DonutSegmentData segment) {
    final size = indicatorSize.width.clamp(12.0, 24.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: segment.color,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Build a rectangular color indicator (with optional rounding and count)
  Widget _buildRectangleIndicator(
    DonutSegmentData segment, {
    required double borderRadius,
  }) {
    return Container(
      width: indicatorSize.width,
      height: indicatorSize.height,
      decoration: BoxDecoration(
        color: segment.color,
        borderRadius: borderRadius > 0
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
      ),
      child: showCount
          ? Center(
              child: Text(
                segment.value.toInt().toString(),
                style: countStyle ??
                    const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          : null,
    );
  }
}

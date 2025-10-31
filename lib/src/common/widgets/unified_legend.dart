import 'package:flutter/material.dart';
import '../models/legend_style.dart';
import '../models/legend_item.dart';

/// Universal legend widget for both RadialRatingChart and RoundedDonutChart
///
/// This widget provides a consistent legend experience across different chart types,
/// supporting emojis, value display, and multiple visual styles.
///
/// Example:
/// ```dart
/// UnifiedLegend(
///   items: [
///     LegendItem(
///       id: '1',
///       label: 'Health',
///       color: Colors.green,
///       emoji: '🏃',
///       value: '8',
///     ),
///   ],
///   style: LegendStyle.roundedRectangle,
///   showValueInIndicator: true,
///   columns: 2,
/// )
/// ```
class UnifiedLegend extends StatelessWidget {
  /// Items to display in the legend
  final List<LegendItem> items;

  /// Visual style of the color indicators
  final LegendStyle style;

  /// Whether to show values inside indicators (for rectangular styles)
  final bool showValueInIndicator;

  /// Number of columns for the legend layout
  final int columns;

  /// Size of the color indicator
  final Size indicatorSize;

  /// Spacing between legend items
  final double spacing;

  /// Text style for labels
  final TextStyle? textStyle;

  /// Text style for value numbers inside indicators
  final TextStyle? valueStyle;

  /// Whether to sort items by ID
  final bool sortById;

  const UnifiedLegend({
    super.key,
    required this.items,
    this.style = LegendStyle.circle,
    this.showValueInIndicator = false,
    this.columns = 2,
    this.indicatorSize = const Size(16, 16),
    this.spacing = 8.0,
    this.textStyle,
    this.valueStyle,
    this.sortById = true,
  });

  @override
  Widget build(BuildContext context) {
    // Sort items if configured
    final sortedItems = List<LegendItem>.from(items);
    if (sortById) {
      sortedItems.sort((a, b) => a.id.compareTo(b.id));
    }

    // Build legend rows
    final List<Widget> rows = [];

    for (int i = 0; i < sortedItems.length; i += columns) {
      final rowItems = <Widget>[];

      for (int j = 0; j < columns; j++) {
        final index = i + j;
        if (index < sortedItems.length) {
          rowItems.add(
            Expanded(
              child: _buildLegendItem(sortedItems[index]),
            ),
          );
        } else {
          // Empty space for incomplete rows
          rowItems.add(const Expanded(child: SizedBox()));
        }

        // Add spacing between columns (but not after last column)
        if (j < columns - 1 && index < sortedItems.length) {
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
  Widget _buildLegendItem(LegendItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Color indicator
        _buildIndicator(item),
        SizedBox(width: spacing),
        // Emoji (if present)
        if (item.emoji != null && item.emoji!.isNotEmpty) ...[
          Text(
            item.emoji!,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 4),
        ],
        // Label
        Expanded(
          child: Text(
            item.label,
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
  Widget _buildIndicator(LegendItem item) {
    switch (style) {
      case LegendStyle.circle:
        return _buildCircleIndicator(item);
      case LegendStyle.rectangle:
        return _buildRectangleIndicator(item, borderRadius: 0);
      case LegendStyle.roundedRectangle:
        return _buildRectangleIndicator(item, borderRadius: 4);
    }
  }

  /// Build a circular color indicator
  Widget _buildCircleIndicator(LegendItem item) {
    final size = style == LegendStyle.circle && !showValueInIndicator
        ? indicatorSize.width.clamp(12.0, 24.0)
        : indicatorSize.width;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: item.color,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Build a rectangular color indicator (with optional rounding and value)
  Widget _buildRectangleIndicator(
    LegendItem item, {
    required double borderRadius,
  }) {
    return Container(
      width: indicatorSize.width,
      height: indicatorSize.height,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: borderRadius > 0
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
      ),
      child: showValueInIndicator && item.value != null
          ? Center(
              child: Text(
                item.value!,
                style: valueStyle ??
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

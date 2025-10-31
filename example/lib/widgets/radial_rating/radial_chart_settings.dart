import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';

/// Shows a bottom sheet for configuring RadialRatingChart settings.
///
/// Allows customization of:
/// - Chart size (200-400)
/// - Grid levels (5-20)
/// - Segment opacity (0.0-1.0)
/// - Show segment borders (toggle)
/// - Show grid (toggle)
/// - Grid color
/// - Legend visibility (toggle)
/// - Legend columns (1-3)
///
/// Returns updated ChartConfig, showLegend, and legendColumns values.
void showRadialChartSettings({
  required BuildContext context,
  required ChartConfig config,
  required bool showLegend,
  required LegendStyle legendStyle,
  required bool showRatingInLegend,
  required int legendColumns,
  required Function(
    ChartConfig config,
    bool showLegend,
    LegendStyle legendStyle,
    bool showRatingInLegend,
    int legendColumns,
  )
  onApply,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RadialChartSettingsSheet(
      config: config,
      showLegend: showLegend,
      legendStyle: legendStyle,
      showRatingInLegend: showRatingInLegend,
      legendColumns: legendColumns,
      onApply: onApply,
    ),
  );
}

class _RadialChartSettingsSheet extends StatefulWidget {
  final ChartConfig config;
  final bool showLegend;
  final LegendStyle legendStyle;
  final bool showRatingInLegend;
  final int legendColumns;
  final Function(
    ChartConfig config,
    bool showLegend,
    LegendStyle legendStyle,
    bool showRatingInLegend,
    int legendColumns,
  )
  onApply;

  const _RadialChartSettingsSheet({
    required this.config,
    required this.showLegend,
    required this.legendStyle,
    required this.showRatingInLegend,
    required this.legendColumns,
    required this.onApply,
  });

  @override
  State<_RadialChartSettingsSheet> createState() =>
      _RadialChartSettingsSheetState();
}

class _RadialChartSettingsSheetState extends State<_RadialChartSettingsSheet> {
  late double _size;
  late int _gridLevels;
  late double _gridStrokeWidth;
  late double _segmentOpacity;
  late bool _showSegmentBorders;
  late double _segmentBorderWidth;
  late Color _gridColor;
  late bool _showLegend;
  late LegendStyle _legendStyle;
  late bool _showRatingInLegend;
  late int _legendColumns;

  @override
  void initState() {
    super.initState();
    _size = widget.config.size;
    _gridLevels = widget.config.gridLevels;
    _gridStrokeWidth = widget.config.gridStrokeWidth;
    _segmentOpacity = widget.config.segmentOpacity;
    _showSegmentBorders = widget.config.showSegmentBorders;
    _segmentBorderWidth = widget.config.segmentBorderWidth;
    _gridColor = widget.config.gridColor;
    _showLegend = widget.showLegend;
    _legendStyle = widget.legendStyle;
    _showRatingInLegend = widget.showRatingInLegend;
    _legendColumns = widget.legendColumns;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(width: 12),
                    Text(
                      'Chart Settings',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Settings list
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // Chart Size
                    _buildSliderSetting(
                      title: 'Chart Size',
                      value: _size,
                      min: 200,
                      max: 400,
                      divisions: 20,
                      onChanged: (value) => setState(() => _size = value),
                    ),

                    const SizedBox(height: 16),

                    // Grid Levels
                    _buildSliderSetting(
                      title: 'Grid Levels',
                      value: _gridLevels.toDouble(),
                      min: 5,
                      max: 20,
                      divisions: 15,
                      onChanged: (value) =>
                          setState(() => _gridLevels = value.round()),
                    ),

                    const SizedBox(height: 16),

                    // Grid Stroke Width
                    _buildSliderSetting(
                      title: 'Grid Stroke Width',
                      value: _gridStrokeWidth,
                      min: 0.5,
                      max: 3.0,
                      divisions: 25,
                      suffix: ' px',
                      onChanged: (value) =>
                          setState(() => _gridStrokeWidth = value),
                    ),

                    const SizedBox(height: 16),

                    // Segment Opacity
                    _buildSliderSetting(
                      title: 'Segment Opacity',
                      value: _segmentOpacity,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      onChanged: (value) =>
                          setState(() => _segmentOpacity = value),
                    ),

                    const SizedBox(height: 16),

                    // Show Segment Borders
                    _buildSwitchSetting(
                      title: 'Show Segment Borders',
                      value: _showSegmentBorders,
                      onChanged: (value) =>
                          setState(() => _showSegmentBorders = value),
                    ),

                    const SizedBox(height: 16),

                    // Segment Border Width
                    _buildSliderSetting(
                      title: 'Segment Border Width',
                      value: _segmentBorderWidth,
                      min: 0.1,
                      max: 3.0,
                      divisions: 29,
                      suffix: ' px',
                      onChanged: (value) =>
                          setState(() => _segmentBorderWidth = value),
                      enabled: _showSegmentBorders,
                    ),

                    const SizedBox(height: 16),

                    // Grid Color
                    _buildColorSetting(
                      title: 'Grid Color',
                      color: _gridColor,
                      onChanged: (color) => setState(() => _gridColor = color),
                    ),

                    const SizedBox(height: 16),

                    const Divider(height: 32),

                    // Legend Section
                    Text(
                      'Legend Settings',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Show Legend
                    _buildSwitchSetting(
                      title: 'Show Legend',
                      value: _showLegend,
                      onChanged: (value) => setState(() => _showLegend = value),
                    ),

                    const SizedBox(height: 16),

                    // Legend Style
                    _buildLegendStyleSetting(),

                    const SizedBox(height: 16),

                    // Show Rating in Legend
                    Opacity(
                      opacity: _showLegend ? 1.0 : 0.5,
                      child: IgnorePointer(
                        ignoring: !_showLegend,
                        child: _buildSwitchSetting(
                          title: 'Show Rating in Legend',
                          value: _showRatingInLegend,
                          onChanged: (value) =>
                              setState(() => _showRatingInLegend = value),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Legend Columns
                    _buildSliderSetting(
                      title: 'Legend Columns',
                      value: _legendColumns.toDouble(),
                      min: 1,
                      max: 3,
                      divisions: 2,
                      onChanged: (value) =>
                          setState(() => _legendColumns = value.round()),
                      enabled: _showLegend,
                    ),
                  ],
                ),
              ),

              // Apply button
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      final newConfig = ChartConfig(
                        size: _size,
                        gridLevels: _gridLevels,
                        gridStrokeWidth: _gridStrokeWidth,
                        segmentOpacity: _segmentOpacity,
                        showSegmentBorders: _showSegmentBorders,
                        segmentBorderWidth: _segmentBorderWidth,
                        gridColor: _gridColor,
                      );
                      widget.onApply(
                        newConfig,
                        _showLegend,
                        _legendStyle,
                        _showRatingInLegend,
                        _legendColumns,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Apply Settings'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliderSetting({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    bool enabled = true,
    String suffix = '',
  }) {
    final displayValue = value % 1 == 0
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text(
              '$displayValue$suffix',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: enabled ? null : Theme.of(context).disabledColor,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: '$displayValue$suffix',
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }

  Widget _buildSwitchSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildColorSetting({
    required String title,
    required Color color,
    required ValueChanged<Color> onChanged,
  }) {
    final presetColors = [
      Colors.black.withValues(alpha: 0.1),
      Colors.black.withValues(alpha: 0.2),
      Colors.black.withValues(alpha: 0.3),
      Colors.grey.withValues(alpha: 0.3),
      Colors.blue.withValues(alpha: 0.2),
      Colors.green.withValues(alpha: 0.2),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: presetColors.map((presetColor) {
            final isSelected = color == presetColor;
            return GestureDetector(
              onTap: () => onChanged(presetColor),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: presetColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.black54, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLegendStyleSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legend Style',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: _showLegend ? null : Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 8),
        SegmentedButton<LegendStyle>(
          segments: const [
            ButtonSegment<LegendStyle>(
              value: LegendStyle.circle,
              label: Text('Circle'),
              icon: Icon(Icons.circle),
            ),
            ButtonSegment<LegendStyle>(
              value: LegendStyle.rectangle,
              label: Text('Rectangle'),
              icon: Icon(Icons.square),
            ),
            ButtonSegment<LegendStyle>(
              value: LegendStyle.roundedRectangle,
              label: Text('Rounded'),
              icon: Icon(Icons.rounded_corner),
            ),
          ],
          selected: {_legendStyle},
          onSelectionChanged: _showLegend
              ? (Set<LegendStyle> newSelection) {
                  setState(() {
                    _legendStyle = newSelection.first;
                  });
                }
              : null,
        ),
      ],
    );
  }
}

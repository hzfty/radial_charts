import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';

/// Shows a bottom sheet for configuring RoundedDonutChart settings.
///
/// Allows customization of:
/// - Chart size (200-400)
/// - Outer radius (100-200)
/// - Inner radius (50-150)
/// - Empty state color
/// - Legend visibility (toggle)
/// - Legend style (circle, rectangle, roundedRectangle)
/// - Legend columns (1-3)
/// - Show count in legend (toggle)
/// - Center text mode (see center_text_settings.dart)
///
/// Returns updated DonutChartConfig, showLegend, legendStyle, legendColumns, and showCountInLegend values.
void showDonutChartSettings({
  required BuildContext context,
  required DonutChartConfig config,
  required bool showLegend,
  required LegendStyle legendStyle,
  required int legendColumns,
  required bool showCountInLegend,
  required Function(
    DonutChartConfig config,
    bool showLegend,
    LegendStyle legendStyle,
    int legendColumns,
    bool showCountInLegend,
  ) onApply,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _DonutChartSettingsSheet(
      config: config,
      showLegend: showLegend,
      legendStyle: legendStyle,
      legendColumns: legendColumns,
      showCountInLegend: showCountInLegend,
      onApply: onApply,
    ),
  );
}

class _DonutChartSettingsSheet extends StatefulWidget {
  final DonutChartConfig config;
  final bool showLegend;
  final LegendStyle legendStyle;
  final int legendColumns;
  final bool showCountInLegend;
  final Function(
    DonutChartConfig config,
    bool showLegend,
    LegendStyle legendStyle,
    int legendColumns,
    bool showCountInLegend,
  ) onApply;

  const _DonutChartSettingsSheet({
    required this.config,
    required this.showLegend,
    required this.legendStyle,
    required this.legendColumns,
    required this.showCountInLegend,
    required this.onApply,
  });

  @override
  State<_DonutChartSettingsSheet> createState() => _DonutChartSettingsSheetState();
}

class _DonutChartSettingsSheetState extends State<_DonutChartSettingsSheet> {
  late double _outerRadius;
  late double _innerRadius;
  late Color _emptyStateColor;
  late bool _showLegend;
  late LegendStyle _legendStyle;
  late int _legendColumns;
  late bool _showCountInLegend;

  @override
  void initState() {
    super.initState();
    _outerRadius = widget.config.outerRadius;
    _innerRadius = widget.config.innerRadius;
    _emptyStateColor = widget.config.emptyStateColor;
    _showLegend = widget.showLegend;
    _legendStyle = widget.legendStyle;
    _legendColumns = widget.legendColumns;
    _showCountInLegend = widget.showCountInLegend;
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                    // Outer Radius
                    _buildSliderSetting(
                      title: 'Outer Radius',
                      value: _outerRadius,
                      min: 50,
                      max: 200,
                      divisions: 30,
                      suffix: ' px',
                      onChanged: (value) => setState(() => _outerRadius = value),
                    ),

                    const SizedBox(height: 16),

                    // Inner Radius
                    _buildSliderSetting(
                      title: 'Inner Radius',
                      value: _innerRadius,
                      min: 30,
                      max: 150,
                      divisions: 24,
                      suffix: ' px',
                      onChanged: (value) => setState(() => _innerRadius = value),
                    ),

                    const SizedBox(height: 16),

                    // Empty State Color
                    _buildColorSetting(
                      title: 'Empty State Color',
                      color: _emptyStateColor,
                      onChanged: (color) => setState(() => _emptyStateColor = color),
                    ),

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

                    // Legend Columns
                    _buildSliderSetting(
                      title: 'Legend Columns',
                      value: _legendColumns.toDouble(),
                      min: 1,
                      max: 3,
                      divisions: 2,
                      onChanged: (value) => setState(() => _legendColumns = value.round()),
                      enabled: _showLegend,
                    ),

                    const SizedBox(height: 16),

                    // Show Count in Legend
                    _buildSwitchSetting(
                      title: 'Show Count in Legend',
                      value: _showCountInLegend,
                      onChanged: (value) => setState(() => _showCountInLegend = value),
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
                      final newConfig = DonutChartConfig(
                        outerRadius: _outerRadius,
                        innerRadius: _innerRadius,
                        emptyStateColor: _emptyStateColor,
                      );
                      widget.onApply(
                        newConfig,
                        _showLegend,
                        _legendStyle,
                        _legendColumns,
                        _showCountInLegend,
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
    final displayValue = value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: enabled ? null : Theme.of(context).disabledColor,
                  ),
            ),
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
    bool enabled = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: enabled ? null : Theme.of(context).disabledColor,
              ),
        ),
        Switch(
          value: value,
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }

  Widget _buildColorSetting({
    required String title,
    required Color color,
    required ValueChanged<Color> onChanged,
  }) {
    final presetColors = [
      Colors.grey.withValues(alpha: 0.2),
      Colors.grey.withValues(alpha: 0.3),
      Colors.grey.withValues(alpha: 0.4),
      Colors.blue.withValues(alpha: 0.2),
      Colors.purple.withValues(alpha: 0.2),
      Colors.orange.withValues(alpha: 0.2),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
                    ? const Icon(
                        Icons.check,
                        color: Colors.black54,
                        size: 20,
                      )
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

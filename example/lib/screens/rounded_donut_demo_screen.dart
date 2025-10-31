import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';
import '../models/donut_segment_model.dart';
import '../widgets/rounded_donut/donut_segment_card.dart';
import '../widgets/rounded_donut/center_text_settings.dart' show CenterTextSettings, CenterTextMode;
import '../widgets/rounded_donut/donut_chart_settings.dart';

class RoundedDonutDemoScreen extends StatefulWidget {
  const RoundedDonutDemoScreen({super.key});

  @override
  State<RoundedDonutDemoScreen> createState() => _RoundedDonutDemoScreenState();
}

class _RoundedDonutDemoScreenState extends State<RoundedDonutDemoScreen> {
  List<DonutSegmentModel> _segments = [];

  // Chart settings
  double _outerRadius = 135.0;
  double _innerRadius = 90.0;
  Color _emptyStateColor = Colors.grey;
  bool _showLegend = true;
  LegendStyle _legendStyle = LegendStyle.circle;
  int _legendColumns = 2;
  bool _showCountInLegend = true;

  // Center text settings
  CenterTextMode _centerTextMode = CenterTextMode.total;
  String _customText = 'Custom Text';

  @override
  void initState() {
    super.initState();
    _loadDefaultSegments();
  }

  void _loadDefaultSegments() {
    _segments = DonutSegmentModel.getDefaultSegments();
  }

  void _updateSegment(int index, DonutSegmentModel updatedSegment) {
    setState(() {
      _segments[index] = updatedSegment;
    });
  }

  void _deleteSegment(int index) {
    setState(() {
      _segments.removeAt(index);
    });
  }

  void _addSegment() {
    setState(() {
      _segments.add(
        DonutSegmentModel.createDefault(_segments.length),
      );
    });
  }

  void _openSettings() {
    showDonutChartSettings(
      context: context,
      config: DonutChartConfig(
        outerRadius: _outerRadius,
        innerRadius: _innerRadius,
        emptyStateColor: _emptyStateColor,
      ),
      showLegend: _showLegend,
      legendStyle: _legendStyle,
      legendColumns: _legendColumns,
      showCountInLegend: _showCountInLegend,
      onApply: (config, showLegend, legendStyle, legendColumns, showCountInLegend) {
        setState(() {
          _outerRadius = config.outerRadius;
          _innerRadius = config.innerRadius;
          _emptyStateColor = config.emptyStateColor;
          _showLegend = showLegend;
          _legendStyle = legendStyle;
          _legendColumns = legendColumns;
          _showCountInLegend = showCountInLegend;
        });
      },
    );
  }

  String? _getCenterText() {
    final total = _segments.fold<double>(0, (sum, s) => sum + s.value);

    switch (_centerTextMode) {
      case CenterTextMode.none:
        return null;
      case CenterTextMode.total:
        return total.toStringAsFixed(0);
      case CenterTextMode.custom:
        return _customText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rounded Donut Chart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center text settings
            CenterTextSettings(
              mode: _centerTextMode,
              customText: _customText,
              onModeChanged: (mode) {
                setState(() {
                  _centerTextMode = mode;
                });
              },
              onCustomTextChanged: (text) {
                setState(() {
                  _customText = text;
                });
              },
            ),
            const SizedBox(height: 24),

            // Rounded Donut Chart
            Center(
              child: RoundedDonutChart(
                data: _segments.map((s) => s.toDonutSegmentData()).toList(),
                config: DonutChartConfig(
                  outerRadius: _outerRadius,
                  innerRadius: _innerRadius,
                  emptyStateColor: _emptyStateColor,
                ),
                showLegend: _showLegend,
                legendStyle: _legendStyle,
                legendColumns: _legendColumns,
                showCountInLegend: _showCountInLegend,
                centerText: _getCenterText(),
                showCenterText: _centerTextMode != CenterTextMode.none,
              ),
            ),
            const SizedBox(height: 32),

            // Segments header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Segments',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${_segments.length} total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Segment cards
            ..._segments.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DonutSegmentCard(
                  segment: entry.value,
                  onChanged: (updated) => _updateSegment(entry.key, updated),
                  onDelete: () => _deleteSegment(entry.key),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Add segment button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addSegment,
                icon: const Icon(Icons.add),
                label: const Text('Add Segment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

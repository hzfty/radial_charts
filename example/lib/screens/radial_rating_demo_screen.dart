import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';
import '../models/radial_segment_model.dart';
import '../widgets/radial_rating/radial_segment_card.dart';
import '../widgets/radial_rating/radial_chart_settings.dart';

class RadialRatingDemoScreen extends StatefulWidget {
  const RadialRatingDemoScreen({super.key});

  @override
  State<RadialRatingDemoScreen> createState() => _RadialRatingDemoScreenState();
}

class _RadialRatingDemoScreenState extends State<RadialRatingDemoScreen> {
  List<RadialSegmentModel> _segments = [];

  // Chart settings
  double _chartSize = 300.0;
  int _gridLevels = 5;
  double _gridStrokeWidth = 1.0;
  double _segmentOpacity = 0.3;
  bool _showSegmentBorders = true;
  double _segmentBorderWidth = 0.5;
  bool _showLegend = true;
  LegendStyle _legendStyle = LegendStyle.circle;
  bool _showRatingInLegend = false;
  Color _gridColor = Colors.grey;
  int _legendColumns = 2;

  @override
  void initState() {
    super.initState();
    _loadDefaultSegments();
  }

  void _loadDefaultSegments() {
    _segments = RadialSegmentModel.getDefaultSegments();
  }

  void _updateSegment(int index, RadialSegmentModel updatedSegment) {
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
      _segments.add(RadialSegmentModel.createDefault(_segments.length));
    });
  }

  void _openSettings() {
    showRadialChartSettings(
      context: context,
      config: ChartConfig(
        size: _chartSize,
        gridLevels: _gridLevels,
        gridStrokeWidth: _gridStrokeWidth,
        segmentOpacity: _segmentOpacity,
        showSegmentBorders: _showSegmentBorders,
        segmentBorderWidth: _segmentBorderWidth,
        gridColor: _gridColor,
      ),
      showLegend: _showLegend,
      legendStyle: _legendStyle,
      showRatingInLegend: _showRatingInLegend,
      legendColumns: _legendColumns,
      onApply:
          (config, showLegend, legendStyle, showRatingInLegend, legendColumns) {
            setState(() {
              _chartSize = config.size;
              _gridLevels = config.gridLevels;
              _gridStrokeWidth = config.gridStrokeWidth;
              _segmentOpacity = config.segmentOpacity;
              _showSegmentBorders = config.showSegmentBorders;
              _segmentBorderWidth = config.segmentBorderWidth;
              _gridColor = config.gridColor;
              _showLegend = showLegend;
              _legendStyle = legendStyle;
              _showRatingInLegend = showRatingInLegend;
              _legendColumns = legendColumns;
            });
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Rating Chart'),
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
            // Radial Rating Chart
            Center(
              child: RadialRatingChart(
                data: _segments.map((s) => s.toCategoryData()).toList(),
                config: ChartConfig(
                  size: _chartSize,
                  gridLevels: _gridLevels,
                  gridStrokeWidth: _gridStrokeWidth,
                  segmentOpacity: _segmentOpacity,
                  showSegmentBorders: _showSegmentBorders,
                  segmentBorderWidth: _segmentBorderWidth,
                  gridColor: _gridColor,
                ),
                showLegend: _showLegend,
                legendStyle: _legendStyle,
                showRatingInLegend: _showRatingInLegend,
                legendColumns: _legendColumns,
              ),
            ),
            const SizedBox(height: 32),

            // Segments header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Segments',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_segments.length} total',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Segment cards
            ..._segments.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: RadialSegmentCard(
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

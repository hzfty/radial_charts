import 'package:flutter/material.dart';

/// Enum representing the center text display mode
enum CenterTextMode {
  /// No center text
  none,

  /// Static custom text
  custom,

  /// Auto-calculated total
  total,
}

/// A widget for selecting center text mode and configuring custom text.
///
/// Displays three options:
/// - None: No center text displayed
/// - Custom: User-provided static text
/// - Total: Auto-calculated sum of all segment values
///
/// When Custom mode is selected, shows a TextField for entering custom text.
class CenterTextSettings extends StatefulWidget {
  /// Current center text mode
  final CenterTextMode mode;

  /// Custom text value (used when mode is custom)
  final String customText;

  /// Callback when mode changes
  final ValueChanged<CenterTextMode> onModeChanged;

  /// Callback when custom text changes
  final ValueChanged<String> onCustomTextChanged;

  const CenterTextSettings({
    super.key,
    required this.mode,
    required this.customText,
    required this.onModeChanged,
    required this.onCustomTextChanged,
  });

  @override
  State<CenterTextSettings> createState() => _CenterTextSettingsState();
}

class _CenterTextSettingsState extends State<CenterTextSettings> {
  late TextEditingController _customTextController;

  @override
  void initState() {
    super.initState();
    _customTextController = TextEditingController(text: widget.customText);
  }

  @override
  void dispose() {
    _customTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Row(
              children: [
                const Icon(Icons.text_fields),
                const SizedBox(width: 8),
                Text(
                  'Center Text',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Mode selection using SegmentedButton
            SegmentedButton<CenterTextMode>(
              segments: const [
                ButtonSegment<CenterTextMode>(
                  value: CenterTextMode.none,
                  label: Text('None'),
                  icon: Icon(Icons.visibility_off),
                ),
                ButtonSegment<CenterTextMode>(
                  value: CenterTextMode.custom,
                  label: Text('Custom'),
                  icon: Icon(Icons.edit),
                ),
                ButtonSegment<CenterTextMode>(
                  value: CenterTextMode.total,
                  label: Text('Total'),
                  icon: Icon(Icons.calculate),
                ),
              ],
              selected: {widget.mode},
              onSelectionChanged: (Set<CenterTextMode> newSelection) {
                widget.onModeChanged(newSelection.first);
              },
            ),

            // Custom text field (shown only when Custom mode is selected)
            if (widget.mode == CenterTextMode.custom) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _customTextController,
                decoration: const InputDecoration(
                  labelText: 'Custom Text',
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: 'Enter text to display...',
                ),
                onChanged: widget.onCustomTextChanged,
              ),
            ],

            // Info text based on mode
            const SizedBox(height: 12),
            _buildInfoText(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    String infoText;
    IconData infoIcon;
    Color infoColor;

    switch (widget.mode) {
      case CenterTextMode.none:
        infoText = 'No text will be displayed in the center of the chart.';
        infoIcon = Icons.info_outline;
        infoColor = Colors.grey;
        break;
      case CenterTextMode.custom:
        infoText = 'Your custom text will be displayed in the center.';
        infoIcon = Icons.check_circle_outline;
        infoColor = Colors.blue;
        break;
      case CenterTextMode.total:
        infoText =
            'The sum of all segment values will be calculated and displayed.';
        infoIcon = Icons.functions;
        infoColor = Colors.green;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(infoIcon, size: 16, color: infoColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            infoText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: infoColor),
          ),
        ),
      ],
    );
  }
}

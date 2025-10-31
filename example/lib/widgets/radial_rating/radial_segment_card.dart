import 'package:flutter/material.dart';
import '../../models/radial_segment_model.dart';
import '../../constants/color_palette.dart';

/// A card widget for editing a RadialSegmentModel.
///
/// Displays all editable properties of a radial chart segment including:
/// - Name (required)
/// - Rating (1-10 via slider)
/// - Color (from ColorPalette)
/// - Emoji (optional)
/// - Description (optional, in ExpansionTile)
///
/// Provides callbacks for changes and deletion.
class RadialSegmentCard extends StatefulWidget {
  /// The segment model to edit
  final RadialSegmentModel segment;

  /// Callback when segment is deleted
  final VoidCallback onDelete;

  /// Callback when segment properties change
  final ValueChanged<RadialSegmentModel> onChanged;

  const RadialSegmentCard({
    super.key,
    required this.segment,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  State<RadialSegmentCard> createState() => _RadialSegmentCardState();
}

class _RadialSegmentCardState extends State<RadialSegmentCard> {
  late TextEditingController _nameController;
  late TextEditingController _emojiController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.segment.name);
    _emojiController = TextEditingController(text: widget.segment.emoji);
    _descriptionController = TextEditingController(
      text: widget.segment.description,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateSegment() {
    widget.segment.name = _nameController.text;
    widget.segment.emoji = _emojiController.text;
    widget.segment.description = _descriptionController.text;
    widget.onChanged(widget.segment);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with delete button
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.segment.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.segment.name.isEmpty
                        ? 'Unnamed Segment'
                        : widget.segment.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: widget.onDelete,
                  tooltip: 'Delete segment',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Name field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => _updateSegment(),
            ),

            const SizedBox(height: 16),

            // Rating slider
            Row(
              children: [
                Text('Rating:', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    value: widget.segment.rating.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: widget.segment.rating.toString(),
                    onChanged: (value) {
                      setState(() {
                        widget.segment.rating = value.round();
                      });
                      _updateSegment();
                    },
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '${widget.segment.rating}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Color picker
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Color:', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ColorPalette.colors.map((color) {
                    final isSelected = widget.segment.color == color;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.segment.color = color;
                        });
                        _updateSegment();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                )
                              : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Emoji field (optional)
            TextField(
              controller: _emojiController,
              decoration: const InputDecoration(
                labelText: 'Emoji (optional)',
                border: OutlineInputBorder(),
                isDense: true,
                hintText: 'e.g. 🏃',
              ),
              onChanged: (_) => _updateSegment(),
              maxLength: 2,
            ),

            const SizedBox(height: 8),

            // Description (optional, in ExpansionTile)
            ExpansionTile(
              title: const Text('Description (optional)'),
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: 8),
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    hintText: 'Add a description...',
                  ),
                  onChanged: (_) => _updateSegment(),
                  maxLines: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

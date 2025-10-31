import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:radial_charts/radial_charts.dart';
import '../constants/color_palette.dart';

class DonutSegmentModel {
  final String id;
  String label;
  double value;
  Color color;
  String emoji;
  String description;

  DonutSegmentModel({
    required this.id,
    required this.label,
    required this.value,
    required this.color,
    this.emoji = '',
    this.description = '',
  });

  DonutSegmentData toDonutSegmentData() {
    return DonutSegmentData(
      id: id,
      value: value,
      color: color,
      label: label,
      emoji: emoji.isEmpty ? null : emoji,
      description: description.isEmpty ? null : description,
    );
  }

  factory DonutSegmentModel.createDefault(int index) {
    const uuid = Uuid();
    return DonutSegmentModel(
      id: uuid.v4(),
      label: 'New Segment',
      value: 10,
      color: ColorPalette.getNextColor(index),
    );
  }

  static List<DonutSegmentModel> getDefaultSegments() {
    return [
      DonutSegmentModel(
        id: '1',
        label: 'Completed',
        value: 45,
        color: const Color(0xFF4CAF50),
      ),
      DonutSegmentModel(
        id: '2',
        label: 'In Progress',
        value: 30,
        color: const Color(0xFF2196F3),
      ),
      DonutSegmentModel(
        id: '3',
        label: 'Pending',
        value: 15,
        color: const Color(0xFFFF9800),
      ),
      DonutSegmentModel(
        id: '4',
        label: 'Failed',
        value: 8,
        color: const Color(0xFFF44336),
      ),
      DonutSegmentModel(
        id: '5',
        label: 'Cancelled',
        value: 2,
        color: const Color(0xFF9E9E9E),
      ),
    ];
  }
}

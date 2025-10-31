import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:radial_charts/radial_charts.dart';
import '../constants/color_palette.dart';

class RadialSegmentModel {
  final String id;
  String name;
  int rating;
  Color color;
  String emoji;
  String description;

  RadialSegmentModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.color,
    this.emoji = '',
    this.description = '',
  });

  CategoryData toCategoryData() {
    return CategoryData(
      category: ChartCategory(
        id: id,
        name: name,
        color: color,
        emoji: emoji.isEmpty ? null : emoji,
        description: description.isEmpty ? null : description,
      ),
      rating: rating.toDouble(),
    );
  }

  factory RadialSegmentModel.createDefault(int index) {
    const uuid = Uuid();
    return RadialSegmentModel(
      id: uuid.v4(),
      name: 'New Category',
      rating: 5,
      color: ColorPalette.getNextColor(index),
      emoji: '',
      description: '',
    );
  }

  static List<RadialSegmentModel> getDefaultSegments() {
    return [
      RadialSegmentModel(
        id: '1',
        name: 'Health',
        rating: 8,
        color: const Color(0xFF4CAF50),
        emoji: '🏃',
      ),
      RadialSegmentModel(
        id: '2',
        name: 'Career',
        rating: 6,
        color: const Color(0xFF2196F3),
        emoji: '💼',
      ),
      RadialSegmentModel(
        id: '3',
        name: 'Relationships',
        rating: 9,
        color: const Color(0xFFE91E63),
        emoji: '❤️',
      ),
      RadialSegmentModel(
        id: '4',
        name: 'Finance',
        rating: 5,
        color: const Color(0xFFFF9800),
        emoji: '💰',
      ),
      RadialSegmentModel(
        id: '5',
        name: 'Personal Growth',
        rating: 7,
        color: const Color(0xFF9C27B0),
        emoji: '🌱',
      ),
    ];
  }
}

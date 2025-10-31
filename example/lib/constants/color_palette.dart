import 'package:flutter/material.dart';

/// Color palette for the demo app
///
/// Provides 12 predefined Material Design colors for segment customization.
class ColorPalette {
  /// List of 12 predefined colors
  static const List<Color> colors = [
    Color(0xFFF44336), // Red
    Color(0xFFFF9800), // Orange
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF4CAF50), // Green
    Color(0xFF2196F3), // Blue
    Color(0xFF9C27B0), // Purple
    Color(0xFF795548), // Brown
    Color(0xFF9E9E9E), // Grey
    Color(0xFFE91E63), // Pink
    Color(0xFF00BCD4), // Cyan
    Color(0xFFCDDC39), // Lime
    Color(0xFFFF5722), // Deep Orange
  ];

  /// Get next color from palette by index (with wrapping)
  static Color getNextColor(int index) {
    return colors[index % colors.length];
  }

  /// Private constructor to prevent instantiation
  ColorPalette._();
}

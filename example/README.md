# Radial Charts Example App

Interactive demo application showcasing the features of the `radial_charts` package.

## Overview

This example app demonstrates both chart types available in the radial_charts package:

- **Radial Rating Chart** - Variable radius segments representing ratings across multiple categories
- **Rounded Donut Chart** - Smooth, rounded donut chart with Bezier curve transitions

## Features Demonstrated

### Radial Rating Chart Demo
- Interactive segment editing with live chart updates
- Customizable chart settings (size, opacity, borders)
- Multiple legend styles and configurations
- Emoji support in categories
- Rating display in legend indicators
- Predefined category templates (Life Balance, Skills, Product Features)

### Rounded Donut Chart Demo
- Dynamic segment management (add, edit, delete)
- Three legend styles (circle, rectangle, roundedRectangle)
- Configurable center text with automatic total calculation
- Empty state visualization
- Single segment handling
- Live chart configuration

## Running the Example

```bash
cd example
flutter run
```

The app features a tab-based interface with two screens, each showcasing one of the chart types with interactive controls.

## Project Structure

```
example/
├── lib/
│   ├── main.dart                      # App entry point with tab navigation
│   ├── screens/                       # Demo screens for each chart type
│   │   ├── radial_rating_demo_screen.dart
│   │   └── rounded_donut_demo_screen.dart
│   ├── widgets/                       # Interactive controls and settings
│   │   ├── radial_rating/            # Radial chart widgets
│   │   └── rounded_donut/            # Donut chart widgets
│   ├── models/                        # Data models for demo
│   └── constants/                     # Predefined categories and colors
```

## Features You Can Try

1. **Edit Segments**: Tap on segment cards to modify values, colors, and labels
2. **Add/Remove Segments**: Use the + button to add new segments or swipe to delete
3. **Customize Appearance**: Adjust size, opacity, borders, and other visual properties
4. **Toggle Legend**: Show/hide legends and try different styles
5. **Center Text**: Configure center text display for donut charts
6. **Emoji Support**: Add emojis to categories for visual identification

## Learn More

For full documentation and API reference, visit the [main package README](../README.md).

# Radial Charts

A collection of customizable radial chart widgets for Flutter. Display ratings and data across multiple categories with variable radius segments, perfect for visualizing assessments, reviews, and multi-dimensional data.

[![pub package](https://img.shields.io/pub/v/radial_charts.svg)](https://pub.dev/packages/radial_charts)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

✨ **Variable Radius Segments** - Each category's segment radius represents its rating value
🍩 **Rounded Donut Chart** - NEW! Donut chart with smooth, rounded segment edges
🎨 **Highly Customizable** - Colors, grid levels, opacity, borders, and more
📦 **Predefined Categories** - Life balance, skills, product features templates
📊 **Legend Support** - Optional legend with customizable layout (multiple styles)
🚀 **Zero Dependencies** - Pure Flutter implementation
⚡ **Performance Optimized** - Efficient CustomPainter rendering

## Screenshots

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/hzfty/radial_charts/main/screenshots/1-life-balance.png" alt="Life Balance" width="300"/></td>
    <td><img src="https://raw.githubusercontent.com/hzfty/radial_charts/main/screenshots/2-skills-assessment.png" alt="Skills Assessment" width="300"/></td>
  </tr>
  <tr>
    <td align="center"><b>Life Balance</b></td>
    <td align="center"><b>Skills Assessment</b></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/hzfty/radial_charts/main/screenshots/3-product-features.png" alt="Product Features" width="300"/></td>
    <td><img src="https://raw.githubusercontent.com/hzfty/radial_charts/main/screenshots/4-custom-example.png" alt="Custom Example" width="300"/></td>
  </tr>
  <tr>
    <td align="center"><b>Product Features</b></td>
    <td align="center"><b>Custom Example (Weekly Mood)</b></td>
  </tr>
</table>

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  radial_charts: ^0.2.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';

RadialRatingChart(
  data: [
    CategoryData(
      category: ChartCategory(
        id: 'health',
        name: 'Health',
        color: Colors.green,
        emoji: '🏃',
      ),
      rating: 8,
    ),
    CategoryData(
      category: ChartCategory(
        id: 'career',
        name: 'Career',
        color: Colors.blue,
        emoji: '💼',
      ),
      rating: 6,
    ),
    CategoryData(
      category: ChartCategory(
        id: 'relationships',
        name: 'Relationships',
        color: Colors.pink,
        emoji: '❤️',
      ),
      rating: 9,
    ),
  ],
  config: ChartConfig(size: 300),
  showLegend: true,
)
```

### With Custom Configuration

```dart
RadialRatingChart(
  data: yourCategoryData,
  config: ChartConfig(
    size: 320,
    maxRating: 10,
    minRating: 1,
    gridLevels: 10,
    gridColor: Colors.grey.withOpacity(0.3),
    segmentOpacity: 0.7,
    showSegmentBorders: true,
  ),
  showLegend: true,
  legendColumns: 2,
)
```

### Using Predefined Categories

The package includes predefined category sets for common use cases:

```dart
// Life Balance
RadialRatingChart(
  data: DefaultCategories.lifeBalance
      .map((cat) => CategoryData(category: cat, rating: 7))
      .toList(),
)

// Skills Assessment
RadialRatingChart(
  data: DefaultCategories.skills
      .map((cat) => CategoryData(category: cat, rating: 8))
      .toList(),
)

// Product Features
RadialRatingChart(
  data: DefaultCategories.productFeatures
      .map((cat) => CategoryData(category: cat, rating: 6))
      .toList(),
)
```

## Rounded Donut Chart

### Basic Example

The `RoundedDonutChart` widget displays data as a donut chart with beautifully rounded, smooth edges between segments.

```dart
import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';

RoundedDonutChart(
  data: [
    DonutSegmentData(
      id: 'completed',
      value: 45,
      color: Colors.green,
      label: 'Completed',
    ),
    DonutSegmentData(
      id: 'pending',
      value: 30,
      color: Colors.orange,
      label: 'Pending',
    ),
    DonutSegmentData(
      id: 'failed',
      value: 25,
      color: Colors.red,
      label: 'Failed',
    ),
  ],
  showCenterText: true,
  centerTextBuilder: (total) => '${total.toInt()}',
  showLegend: true,
  legendStyle: LegendStyle.roundedRectangle,
  showCountInLegend: true,
)
```

### With Custom Configuration

```dart
RoundedDonutChart(
  data: yourSegmentData,
  config: DonutChartConfig(
    size: 270,
    outerRadius: 135,
    innerRadius: 100,
    startAngle: -math.pi / 2,
    sortSegmentsById: true,
  ),
  // Center text options
  centerText: '100',  // Or use centerTextBuilder for dynamic text
  centerTextStyle: TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  ),
  showCenterText: true,
  // Legend options
  showLegend: true,
  legendStyle: LegendStyle.roundedRectangle, // or circle, rectangle
  legendColumns: 2,
  legendIndicatorSize: Size(33, 28),
  showCountInLegend: true,
)
```

### Legend Styles

The `RoundedDonutChart` supports three legend styles:

- **`LegendStyle.circle`** - Circular indicators (similar to RadialRatingChart)
- **`LegendStyle.rectangle`** - Square indicators with sharp corners
- **`LegendStyle.roundedRectangle`** - Rounded rectangle indicators with optional count badges (default)

## API Reference

### RadialRatingChart

Main widget for displaying the chart.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `data` | `List<CategoryData>` | required | List of category data to display |
| `config` | `ChartConfig?` | `ChartConfig()` | Configuration for chart appearance |
| `showLegend` | `bool` | `false` | Whether to show legend |
| `legendColumns` | `int` | `2` | Number of columns in legend |
| `legendSpacing` | `double` | `8.0` | Spacing between legend items |
| `legendIndicatorSize` | `double` | `16.0` | Size of color indicator |
| `legendTextStyle` | `TextStyle?` | `null` | Text style for legend |

### ChartCategory

Represents a category in the chart.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | `String` | ✅ | Unique identifier |
| `name` | `String` | ✅ | Display name |
| `color` | `Color` | ✅ | Segment color |
| `emoji` | `String?` | ❌ | Optional emoji/icon |
| `description` | `String?` | ❌ | Optional description |

### CategoryData

Combines a category with its rating value.

| Property | Type | Description |
|----------|------|-------------|
| `category` | `ChartCategory` | The category being rated |
| `rating` | `double` | Rating value (typically 1-10) |

### ChartConfig

Configuration for chart appearance.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `size` | `double` | `280.0` | Chart size (width & height) |
| `maxRating` | `int` | `10` | Maximum rating value |
| `minRating` | `int` | `1` | Minimum rating value |
| `gridLevels` | `int` | `10` | Number of concentric circles |
| `gridColor` | `Color` | `Color(0x4D000000)` | Grid line color |
| `gridStrokeWidth` | `double` | `1.0` | Grid line width |
| `segmentOpacity` | `double` | `0.7` | Segment opacity (0.0-1.0) |
| `showSegmentBorders` | `bool` | `true` | Show segment borders |
| `segmentBorderColor` | `Color?` | `null` | Border color (auto if null) |
| `segmentBorderWidth` | `double` | `0.5` | Border width |
| `startAngle` | `double` | `-π/2` | Start angle in radians |
| `sortCategoriesById` | `bool` | `true` | Sort categories by ID |

### RoundedDonutChart

Main widget for displaying the rounded donut chart.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `data` | `List<DonutSegmentData>` | required | List of segment data to display |
| `config` | `DonutChartConfig?` | `DonutChartConfig()` | Configuration for chart appearance |
| `centerText` | `String?` | `null` | Static text to display in center |
| `centerTextBuilder` | `String Function(double)?` | `null` | Function to generate center text from total |
| `centerTextStyle` | `TextStyle?` | default style | Text style for center text |
| `showCenterText` | `bool` | `true` | Whether to show center text |
| `showLegend` | `bool` | `false` | Whether to show legend |
| `legendStyle` | `LegendStyle` | `roundedRectangle` | Visual style of legend indicators |
| `legendColumns` | `int` | `2` | Number of columns in legend |
| `legendIndicatorSize` | `Size` | `Size(33, 28)` | Size of legend color indicators |
| `showCountInLegend` | `bool` | `true` | Show count values in indicators |
| `legendSpacing` | `double` | `8.0` | Spacing between legend items |
| `legendTextStyle` | `TextStyle?` | `null` | Text style for legend labels |
| `legendCountStyle` | `TextStyle?` | `null` | Text style for legend counts |

### DonutSegmentData

Represents a segment (slice) in the donut chart.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | `String` | ✅ | Unique identifier |
| `value` | `double` | ✅ | Numerical value (segment size) |
| `color` | `Color` | ✅ | Segment color |
| `label` | `String` | ✅ | Display label |
| `description` | `String?` | ❌ | Optional description |
| `metadata` | `Map<String, dynamic>?` | ❌ | Optional metadata |

### DonutChartConfig

Configuration for donut chart appearance.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `size` | `double` | `270.0` | Chart size (width & height) |
| `outerRadius` | `double` | `135.0` | Outer radius of donut ring |
| `innerRadius` | `double` | `100.0` | Inner radius (creates center hole) |
| `startAngle` | `double` | `-π/2` | Start angle in radians |
| `sortSegmentsById` | `bool` | `true` | Sort segments by ID |
| `emptyStateColor` | `Color` | `Color(0x4DBCB5C0)` | Background color for empty state |
| `emptyStateBorderColor` | `Color` | `Color(0xFFE0E0E0)` | Border color for empty state |
| `emptyStateBorderWidth` | `double` | `2.0` | Border width for empty state |

### LegendStyle

Enum defining legend indicator styles.

- `circle` - Circular indicators
- `rectangle` - Rectangular indicators with sharp corners
- `roundedRectangle` - Rectangular indicators with rounded corners

## Examples

Check out the `example` folder for complete examples including:

- Life Balance Assessment
- Skills Proficiency Chart
- Product Features Rating
- Custom Data Visualization

Run the example:

```bash
cd example
flutter run
```

## Use Cases

- 📊 **Life Balance Wheels** - Track satisfaction across life areas
- 💼 **Skills Assessment** - Visualize competency levels
- ⭐ **Product Reviews** - Display multi-dimensional ratings
- 📈 **Performance Metrics** - Show KPIs across categories
- 🎯 **Goal Tracking** - Monitor progress in different areas
- 📝 **Survey Results** - Present multi-category survey data

## How It Works

The Radial Rating Chart is a variation of a pie chart where:
- Each segment represents a category
- The **radius** of each segment varies based on the rating (unlike traditional pie charts)
- Higher ratings extend further from the center
- The chart includes a grid for easy value reading

This makes it perfect for comparing multiple ratings at a glance, especially when you want to see which areas score higher or lower.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by [hzfty](https://github.com/hzfty)

## Support

If you find this package useful, please give it a ⭐ on GitHub!

For bugs or feature requests, please file an issue on GitHub Issues.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

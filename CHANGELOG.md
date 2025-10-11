# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2025-10-11

### Changed
- Add screenshots gallery to pub.dev package page
- Screenshots are now displayed in a dedicated gallery on pub.dev
- First screenshot is used as package thumbnail

## [0.1.0] - 2025-10-11

### Added
- Initial release of Radial Charts package
- `RadialRatingChart` widget for displaying radial rating charts
- `ChartCategory` model for defining categories
- `CategoryData` model for category ratings
- `ChartConfig` for customizing chart appearance
- `RadialChartPainter` custom painter for rendering
- Predefined category sets:
  - Life Balance categories (11 categories)
  - Skills Assessment categories (5 categories)
  - Product Features categories (5 categories)
- Legend support with customizable layout
- Configurable grid levels, colors, opacity, and borders
- Support for variable radius segments based on ratings
- Sorting categories by ID for consistent positioning
- Zero external dependencies (pure Flutter)
- Comprehensive documentation and examples
- Example app with 4 different demo scenarios

### Features
- Variable radius segments representing rating values
- Highly customizable appearance (colors, grid, opacity, borders)
- Optional legend with multi-column layout
- Adaptive segment count (1 to N categories)
- Special handling for single-category display (full circle)
- Performance-optimized CustomPainter
- Full control over start angle and grid levels
- Support for emoji/icons in categories

### Documentation
- Complete README with usage examples
- API reference documentation
- Multiple use case examples
- Contributing guidelines
- MIT License

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.1] - 2025-10-31

### Changed
- Optimized GIF screenshots to meet pub.dev 4MB file size limit (reduced from 4+ MB to ~3 MB each)
- Improved package description for better clarity and professionalism
- Reduced total package size from 10 MB to 5 MB

### Fixed
- Fixed package screenshots exceeding pub.dev file size limit

## [0.2.0] - 2025-10-31

### Added
- **RoundedDonutChart** - new chart type with smooth rounded segment edges
  - `DonutSegmentData` model for donut chart segments
  - `DonutChartConfig` for chart configuration (size, radii, colors)
  - Support for emoji in segments
  - Customizable legend styles (circle, rectangle, roundedRectangle)
  - Value display inside legend indicators
  - Custom text in chart center
- **Unified Legend System** - shared legend architecture for both chart types
  - `UnifiedLegend` widget used by both RadialRatingChart and RoundedDonutChart
  - `LegendItem` - universal legend item model
  - Emoji support in legends for both charts
  - Consistent styles and behavior across charts
- **RadialRatingChart enhancements:**
  - `showRatingInLegend` parameter to display rating values in legend
  - `legendRatingStyle` parameter for value text styling
  - Automatic indicator size adjustment when values are enabled
  - Emoji support in categories
- **Example app completely redesigned:**
  - Two separate screens showcasing each chart type
  - Interactive settings (ChartSettings) with live preview
  - Editable segment/category cards
  - Material Design 3 interface
  - Modular structure (constants, models, screens, widgets)

### Fixed
- RadialRatingChart: fixed vertical line appearing with only one category

### Changed
- **BREAKING:** Both charts now use `UnifiedLegend` instead of separate implementations
- **BREAKING:** `LegendStyle` enum moved from `rounded_donut_chart/models/` to `common/models/`
- Standardized spacing between charts and legends (spacing * 3)
- Simplified RadialRatingChart API (removed maxRating, minRating, sortCategoriesById from widget parameters)
- Example app: main.dart reduced from 395 lines to compact structure

### Internal
- Created `lib/src/common/` folder for shared components
- Added architecture foundation for future chart types
- Improved code modularity and reusability

### Old [Unreleased] content (keeping for reference):
- **RoundedDonutChart**: New donut chart widget with rounded segment edges
  - Smooth Bezier curve transitions between segments for a polished look
  - Two-pass rendering algorithm for seamless rounded edges
  - Configurable center text with automatic total calculation
  - Three legend styles: `circle`, `rectangle`, and `roundedRectangle`
  - Optional count badges displayed inside legend indicators
  - Support for empty state and single-segment visualization
  - Fully customizable colors, sizes, radii, and text styles
- New models for RoundedDonutChart:
  - `DonutSegmentData`: Flexible data model with id, value, color, label, and metadata
  - `DonutChartConfig`: Configuration for donut appearance and behavior
  - `LegendStyle`: Enum for legend indicator styles
- New painters:
  - `RoundedDonutPainter`: Main painter for multiple segments with rounded edges
  - `SingleItemDonutPainter`: Optimized painter for single-segment charts
- Comprehensive documentation for RoundedDonutChart in README
- API reference documentation for all new components

### Features
- Rounded edge algorithm using cubic Bezier curves with 4x radius enhancement
- Automatic handling of edge cases (empty data, single segment, multiple segments)
- Flexible center text: static string or dynamic builder function
- Multi-column legend layout with configurable spacing
- Support for metadata in segment data for custom use cases
- Consistent API design matching existing RadialRatingChart pattern

## [0.1.3] - 2025-10-11

### Fixed
- Fix screenshot display in README on both pub.dev and GitHub
- Use absolute GitHub URLs for screenshots instead of relative paths
- Screenshots now properly display in package documentation

## [0.1.2] - 2025-10-11

### Fixed
- Fix screenshot display on pub.dev by removing spaces from filenames
- Screenshots now properly display in package gallery and as thumbnail

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

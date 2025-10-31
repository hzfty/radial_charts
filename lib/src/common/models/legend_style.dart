/// Defines the visual style of legend indicators
///
/// The legend style determines how the color indicators are displayed
/// next to the legend labels.
///
/// Example:
/// ```dart
/// RoundedDonutChart(
///   legendStyle: LegendStyle.roundedRectangle,
///   // ...
/// )
/// ```
enum LegendStyle {
  /// Circular indicator (similar to RadialRatingChart)
  circle,

  /// Rectangular indicator with sharp corners
  rectangle,

  /// Rectangular indicator with rounded corners (default style)
  roundedRectangle,
}

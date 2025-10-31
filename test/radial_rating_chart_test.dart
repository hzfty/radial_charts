import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radial_charts/radial_charts.dart';

void main() {
  group('ChartCategory', () {
    test('creates category with required fields', () {
      const category = ChartCategory(
        id: 'test',
        name: 'Test Category',
        color: Colors.blue,
      );

      expect(category.id, 'test');
      expect(category.name, 'Test Category');
      expect(category.color, Colors.blue);
      expect(category.emoji, null);
    });

    test('creates category with emoji', () {
      const category = ChartCategory(
        id: 'test',
        name: 'Test',
        color: Colors.blue,
        emoji: '🎯',
      );

      expect(category.emoji, '🎯');
    });
  });

  group('CategoryData', () {
    test('creates category data', () {
      const category = ChartCategory(
        id: 'test',
        name: 'Test',
        color: Colors.blue,
      );
      const data = CategoryData(category: category, rating: 8);

      expect(data.category, category);
      expect(data.rating, 8);
      expect(data.id, 'test');
      expect(data.name, 'Test');
    });
  });

  group('ChartConfig', () {
    test('creates config with default values', () {
      const config = ChartConfig();

      expect(config.size, 280.0);
      expect(config.maxRating, 10);
      expect(config.minRating, 0);
      expect(config.gridLevels, 10);
      expect(config.segmentOpacity, 0.7);
    });

    test('creates config with custom values', () {
      const config = ChartConfig(
        size: 400,
        maxRating: 5,
        minRating: 0,
      );

      expect(config.size, 400);
      expect(config.maxRating, 5);
      expect(config.minRating, 0);
    });
  });

  group('RadialRatingChart Widget', () {
    testWidgets('renders without error', (WidgetTester tester) async {
      const data = [
        CategoryData(
          category: ChartCategory(
            id: 'test1',
            name: 'Test 1',
            color: Colors.blue,
          ),
          rating: 8,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'test2',
            name: 'Test 2',
            color: Colors.red,
          ),
          rating: 6,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadialRatingChart(data: data),
          ),
        ),
      );

      expect(find.byType(RadialRatingChart), findsOneWidget);
    });

    testWidgets('renders with legend', (WidgetTester tester) async {
      const data = [
        CategoryData(
          category: ChartCategory(
            id: 'test',
            name: 'Test',
            color: Colors.blue,
          ),
          rating: 8,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadialRatingChart(
              data: data,
              showLegend: true,
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });
}

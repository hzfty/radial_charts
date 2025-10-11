import 'package:flutter/material.dart';
import 'package:radial_charts/radial_charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radial Rating Chart Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _selectedDemo = 0;

  final List<String> _demoTitles = [
    'Life Balance',
    'Skills Assessment',
    'Product Features',
    'Custom Example',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Rating Chart Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Demo selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Demo:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_demoTitles.length, (index) {
                        return ChoiceChip(
                          label: Text(_demoTitles[index]),
                          selected: _selectedDemo == index,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedDemo = index);
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Chart display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _buildSelectedDemo(),
              ),
            ),

            const SizedBox(height: 24),

            // Description
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About this chart:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_getDescription()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedDemo() {
    switch (_selectedDemo) {
      case 0:
        return _buildLifeBalanceDemo();
      case 1:
        return _buildSkillsDemo();
      case 2:
        return _buildProductDemo();
      case 3:
        return _buildCustomDemo();
      default:
        return _buildLifeBalanceDemo();
    }
  }

  Widget _buildLifeBalanceDemo() {
    return RadialRatingChart(
      data: const [
        CategoryData(
          category: ChartCategory(
            id: 'health',
            name: 'Health',
            color: Color(0xFFFF81BE),
            emoji: '🏃',
          ),
          rating: 8,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'career',
            name: 'Career',
            color: Color(0xFF13E1AA),
            emoji: '💼',
          ),
          rating: 7,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'relationships',
            name: 'Relationships',
            color: Color(0xFFFFDBDB),
            emoji: '❤️',
          ),
          rating: 9,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'finance',
            name: 'Finance',
            color: Color(0xFFF677FF),
            emoji: '💰',
          ),
          rating: 6,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'personal_growth',
            name: 'Personal Growth',
            color: Color(0xFFE53838),
            emoji: '🤩',
          ),
          rating: 7,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'entertainment',
            name: 'Entertainment',
            color: Color(0xFF93B9FF),
            emoji: '🎮',
          ),
          rating: 8,
        ),
      ],
      config: const ChartConfig(size: 320),
      showLegend: true,
      legendColumns: 2,
    );
  }

  Widget _buildSkillsDemo() {
    return RadialRatingChart(
      data: const [
        CategoryData(
          category: ChartCategory(
            id: 'technical',
            name: 'Technical',
            color: Color(0xFF2196F3),
            emoji: '💻',
          ),
          rating: 9,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'communication',
            name: 'Communication',
            color: Color(0xFF4CAF50),
            emoji: '💬',
          ),
          rating: 7,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'leadership',
            name: 'Leadership',
            color: Color(0xFFFF9800),
            emoji: '👑',
          ),
          rating: 6,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'creativity',
            name: 'Creativity',
            color: Color(0xFF9C27B0),
            emoji: '🎨',
          ),
          rating: 8,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'problem_solving',
            name: 'Problem Solving',
            color: Color(0xFFF44336),
            emoji: '🧩',
          ),
          rating: 8,
        ),
      ],
      config: const ChartConfig(
        size: 300,
        segmentOpacity: 0.8,
      ),
      showLegend: true,
      legendColumns: 1,
    );
  }

  Widget _buildProductDemo() {
    return RadialRatingChart(
      data: const [
        CategoryData(
          category: ChartCategory(
            id: 'usability',
            name: 'Usability',
            color: Color(0xFF00BCD4),
          ),
          rating: 9,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'performance',
            name: 'Performance',
            color: Color(0xFF8BC34A),
          ),
          rating: 7,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'design',
            name: 'Design',
            color: Color(0xFFE91E63),
          ),
          rating: 8,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'features',
            name: 'Features',
            color: Color(0xFF673AB7),
          ),
          rating: 6,
        ),
      ],
      config: const ChartConfig(
        size: 280,
        gridLevels: 5,
        showSegmentBorders: false,
      ),
      showLegend: true,
    );
  }

  Widget _buildCustomDemo() {
    return RadialRatingChart(
      data: const [
        CategoryData(
          category: ChartCategory(
            id: 'monday',
            name: 'Monday',
            color: Colors.red,
          ),
          rating: 3,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'tuesday',
            name: 'Tuesday',
            color: Colors.orange,
          ),
          rating: 5,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'wednesday',
            name: 'Wednesday',
            color: Colors.yellow,
          ),
          rating: 6,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'thursday',
            name: 'Thursday',
            color: Colors.green,
          ),
          rating: 7,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'friday',
            name: 'Friday',
            color: Colors.blue,
          ),
          rating: 9,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'saturday',
            name: 'Saturday',
            color: Colors.indigo,
          ),
          rating: 10,
        ),
        CategoryData(
          category: ChartCategory(
            id: 'sunday',
            name: 'Sunday',
            color: Colors.purple,
          ),
          rating: 8,
        ),
      ],
      config: const ChartConfig(
        size: 350,
        gridColor: Color(0x33000000),
        segmentOpacity: 0.6,
      ),
      showLegend: true,
      legendColumns: 2,
    );
  }

  String _getDescription() {
    switch (_selectedDemo) {
      case 0:
        return 'Life Balance chart shows satisfaction levels across different life areas. '
            'Each segment represents a life category with radius proportional to the rating.';
      case 1:
        return 'Skills Assessment visualizes proficiency levels across different skill categories. '
            'Higher ratings extend further from the center.';
      case 2:
        return 'Product Features chart displays ratings for different product aspects. '
            'This example uses 5 grid levels instead of the default 10.';
      case 3:
        return 'Custom Example: Weekly mood ratings! Shows how the chart adapts to any data. '
            'Friday and Saturday clearly stand out!';
      default:
        return '';
    }
  }
}

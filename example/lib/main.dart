import 'package:flutter/material.dart';
import 'screens/radial_rating_demo_screen.dart';
import 'screens/rounded_donut_demo_screen.dart';

void main() {
  runApp(const RadialChartsDemo());
}

class RadialChartsDemo extends StatelessWidget {
  const RadialChartsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radial Charts Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoTabScreen(),
    );
  }
}

class DemoTabScreen extends StatelessWidget {
  const DemoTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Radial Charts Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.radar), text: 'Radial Rating'),
              Tab(icon: Icon(Icons.donut_small), text: 'Rounded Donut'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [RadialRatingDemoScreen(), RoundedDonutDemoScreen()],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'M3 Colors'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: buildColorList());
  }

  Widget buildColorList() {
    const stepSize = 10.0;
    final colorList = <Color>[];
    for (double h = 0; h < 360; h += stepSize) {
      final color = HSLColor.fromAHSL(1.0, h, 1.0, 0.5);
      colorList.add(color.toColor());
    }

    return ListView.builder(
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        final color = colorList[index];

        return ListTile(
          leading: buildColorTile(color),
          title: Text('[${index + 1}] $color'),
          subtitle: Row(
            children: [
              buildColorGroup(color, DynamicSchemeVariant.tonalSpot),
              const SizedBox(width: 10),
              buildColorGroup(color, DynamicSchemeVariant.fidelity),
              const SizedBox(width: 10),
              buildColorGroup(color, DynamicSchemeVariant.vibrant),
            ],
          ),
        );
      },
    );
  }

  Widget buildColorGroup(Color color, DynamicSchemeVariant variant) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.light,
      dynamicSchemeVariant: variant,
    );
    final colorSchemeDark = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
      dynamicSchemeVariant: variant,
    );
    return Column(
      children: [
        Text(
          variant.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          color: Colors.grey.shade300,
          child: Row(
            children: [
              buildColorTile(colorScheme.primary),
              buildColorTile(colorScheme.secondary),
              buildColorTile(colorScheme.tertiary),
              buildColorTile(colorScheme.error),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.all(4),
          color: Colors.black,
          child: Row(
            children: [
              buildColorTile(colorSchemeDark.primary),
              buildColorTile(colorSchemeDark.secondary),
              buildColorTile(colorSchemeDark.tertiary),
              buildColorTile(colorSchemeDark.error),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildColorTile(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        color: color,
        height: 20,
        width: 20,
      ),
    );
  }
}

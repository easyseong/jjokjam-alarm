import 'package:flutter/material.dart';

class SelectLinePage extends StatelessWidget {
  final void Function(String) onLineSelected;
  const SelectLinePage({super.key, required this.onLineSelected});

  final List<String> _lines = const [
    '1호선', '2호선', '3호선', '4호선', '5호선',
    '6호선', '7호선', '8호선', '9호선',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('호선 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: _lines.map((line) {
            return ElevatedButton(
              onPressed: () => onLineSelected(line),
              child: Text(line),
            );
          }).toList(),
        ),
      ),
    );
  }
}
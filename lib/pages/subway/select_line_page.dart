import 'package:flutter/cupertino.dart';

class SelectLinePage extends StatelessWidget {
  final void Function(String) onLineSelected;

  const SelectLinePage({super.key, required this.onLineSelected});

  final List<String> _lines = const [
    '1호선',
    '2호선',
    '3호선',
    '4호선',
    '5호선',
    '6호선',
    '7호선',
    '8호선',
    '9호선',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('호선 선택')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children:
                _lines.map((line) {
                  return CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: () => onLineSelected(line),
                    child: Text(line, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

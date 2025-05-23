import 'package:flutter/cupertino.dart';

class SubwayLinePage extends StatelessWidget {
  final String line;

  const SubwayLinePage({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$line 노선'),
        previousPageTitle: '뒤로',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoSearchTextField(placeholder: '지하철역 검색'),
              const SizedBox(height: 24),
              const Text(
                '노선도 추가',
                style: TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

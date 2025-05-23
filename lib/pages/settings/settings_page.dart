import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final List<String> _menuItems = const ['알람 설정', '문의하기', '오픈소스 정보'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('설정'),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: null,
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: _menuItems.length,
          itemBuilder: (context, index) {
            return Container(
              color: CupertinoColors.white,
              child: Column(
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    color: CupertinoColors.white,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _menuItems[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.label,
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 20,
                          color: CupertinoColors.systemGrey,
                        ),
                      ],
                    ),
                  ),
                  if (index != _menuItems.length - 1)
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: CupertinoColors.systemGrey4,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

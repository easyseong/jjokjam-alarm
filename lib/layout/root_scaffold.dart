import 'package:flutter/cupertino.dart';

import '../pages/main/main_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/subway/select_line_page.dart';
import '../pages/subway/subway_line_page.dart';

class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _selectedTabIndex = 0; // 현재 선택된 하단 탭 인덱스
  late Widget _subwayTab; // 보여줄 페이지

  @override
  void initState() {
    // 위젯 처음 생성시 호출
    super.initState();
    _subwayTab = SelectLinePage(onLineSelected: _onLineSelected);
  }

  // 지하철 노선을 선택하면 호출 (_subwayTab을 해당 노선의 페이지로 교체하고 UI를 다시 렌더링)
  void _onLineSelected(String line) {
    setState(() {
      _subwayTab = SubwayLinePage(line: line);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemBackground,
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.timer),
            label: '타이머',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.train_style_one),
            label: '알람',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: '설정',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const MainPage();
          case 1:
            return _subwayTab;
          case 2:
            return const SettingsPage();
          default:
            return const MainPage();
        }
      },
    );
  }
}

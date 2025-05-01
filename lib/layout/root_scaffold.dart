import 'package:flutter/material.dart';
import '../pages/main/main_page.dart';
import '../pages/subway/select_line_page.dart';
import '../pages/subway/subway_line_page.dart';
import '../pages/settings/settings_page.dart';

class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _selectedTabIndex = 0;
  Widget _currentPage = const MainPage();

  void _onLineSelected(String line) {
    setState(() {
      _currentPage = SubwayLinePage(line: line);
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedTabIndex = index;
      switch (index) {
        case 0:
          _currentPage = const MainPage();
          break;
        case 1:
          _currentPage = SelectLinePage(onLineSelected: _onLineSelected);
          break;
        case 2:
          _currentPage = const SettingsPage();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: '시계'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '알람'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
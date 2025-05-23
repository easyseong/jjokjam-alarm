import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../layout/root_scaffold.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // 위젯 처음실행시 1번호출됨
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // 2초뒤에 실행됨
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (_) => const RootScaffold(),
        ), // 현제 페이지를 제거하고 RootScaffold를 새로 띄움
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      // 기본구조, 화면의 기본구조를 담당함
      navigationBar: null,
      child: Center(
        child: Text(
          'Subway Alarm App',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

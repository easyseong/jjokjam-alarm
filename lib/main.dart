import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/splash/splash_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Subway Alarm App',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
      ),
      home: const SplashPage(),
    );
  }
}

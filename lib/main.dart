import 'package:flutter/material.dart';

import 'game_screen.dart';

void main() {
  runApp(const TicTakGameApp());
}

class TicTakGameApp extends StatelessWidget {
  const TicTakGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Color.fromARGB(255, 146, 18, 168),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

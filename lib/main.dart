import 'package:flutter/material.dart';
import 'package:xo_game/Screens/pick_player_screen.dart';
import 'package:xo_game/Screens/xo_screen.dart';

void main() {
  runApp(const XoGame());
}

class XoGame extends StatelessWidget {
  const XoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PickPlayerScreen.routeName,
      routes: {
        PickPlayerScreen.routeName: (_) => const PickPlayerScreen(),
        XoScreen.routeName: (_) => const XoScreen(),
      },
    );
  }
}

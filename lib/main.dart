import 'package:ricks_games_hub/Pages/game_page.dart';
import 'package:ricks_games_hub/Provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricks_games_hub/Provider/genre_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => GenreProvider())
      ],
      child: const MaterialApp(
        home: GamePage()
      ),
    );
  }
}

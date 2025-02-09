import 'package:ricks_games_hub/Enum/game_status.dart';
import 'package:ricks_games_hub/Model/game.dart';
import 'package:ricks_games_hub/source/game_source.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  String genre = 'Shooter';
  setGenre(String n) {
    genre = n;
    notifyListeners();
  }

  GameStatus status = GameStatus.initial;

  List<Game> _games = [];
  List<Game> get games => _games;

  fetchLiveGame() async {
    status = GameStatus.loading;
    notifyListeners();

    final list = await GameSource.getLiveGame();
    if(list == null) {
      await Future.delayed(const Duration(seconds: 2));
      status = GameStatus.failure;
      notifyListeners();
      return;
    } 

    _games = list;
    status = GameStatus.loaded;
    notifyListeners();
  }
}
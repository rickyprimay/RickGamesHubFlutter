import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ricks_games_hub/Enum/game_status.dart';
import 'package:ricks_games_hub/Model/game.dart';
import 'package:ricks_games_hub/Provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<String> genres = ['Shooter', 'MMOARPG', 'ARPG', 'Strategy', 'Fighting'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().fetchLiveGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Rick Games Hub',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildGenreSelector(context),
          Expanded(child: _buildGameGrid()),
        ],
      ),
    );
  }

  Widget _buildGenreSelector(BuildContext context) {
    String genreSelected = context.watch<GameProvider>().genre;
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(genre, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              selected: genreSelected == genre,
              onSelected: (selected) => context.read<GameProvider>().setGenre(genre),
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[800],
              labelStyle: TextStyle(color: genreSelected == genre ? Colors.white : Colors.black),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameGrid() {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.status == GameStatus.loading) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        if (gameProvider.status == GameStatus.failure) {
          return const Center(child: Text('Something went wrong!', style: TextStyle(color: Colors.white)));
        }
        
        List<Game> games = gameProvider.games.where((game) => game.genre == gameProvider.genre).toList();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return GameCard(game: games[index]);
            },
          ),
        );
      },
    );
  }
}

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: ExtendedImage.network(
                game.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
                cache: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          game.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: game.saved ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {
                          if(game.saved) {
                            context.read<GameProvider>().setIsSaved(game, false);
                          } else {
                            context.read<GameProvider>().setIsSaved(game, true);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(game.genre, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

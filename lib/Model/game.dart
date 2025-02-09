class Game {
    int id;
    String title;
    String thumbnail;
    String shortDescription;
    String gameUrl;
    String genre;
    String platform;
    String publisher;
    String developer;
    DateTime releaseDate;
    String freetogameProfileUrl;
    bool saved;

    Game({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.shortDescription,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
        this.saved = false
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
    );


  Game copyWith({
    int? id,
    String? title,
    String? thumbnail,
    String? shortDescription,
    String? gameUrl,
    String? genre,
    String? platform,
    String? publisher,
    String? developer,
    DateTime? releaseDate,
    String? freetogameProfileUrl,
    bool? saved,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      shortDescription: shortDescription ?? this.shortDescription,
      gameUrl: gameUrl ?? this.gameUrl,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      publisher: publisher ?? this.publisher,
      developer: developer ?? this.developer,
      releaseDate: releaseDate ?? this.releaseDate,
      freetogameProfileUrl: freetogameProfileUrl ?? this.freetogameProfileUrl,
      saved: saved ?? this.saved,
    );
  }
}

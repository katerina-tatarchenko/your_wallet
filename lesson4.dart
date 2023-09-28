class Song {
  Song(
    this.name,
    this.artist,
    this.duration,
    this.year,
  );

  final String name;
  final String artist;
  final Duration duration;
  final int year;
}

class Playlist with SearchMixin {
  Playlist(
    this.name,
    this.songs,
  );

  final String name;
  final List<Song> songs;


  List<Song> search(String query) {
    return _search(songs, query);
  }
}

//створення міксину з умовою фільтрації списку
mixin SearchMixin {
  List<Song> _search(List<Song> songs, String query) {
    final lowercaseQuery = query.toLowerCase();

    return songs.where((item) {
      final lowerName = item.name.toLowerCase();
      final lowerArtist = item.artist.toLowerCase();

      return lowerName.contains(lowercaseQuery) ||
          lowerArtist.contains(lowercaseQuery);
    }).toList();
  }
}

//розрахунок загальної тривалості пісень у плейлисті
extension LengthSongs on List<Song> {
  Duration timeSongs() {
    return fold(Duration.zero, (previousValue, song) => previousValue + song.duration);
  } 
}

void main() {
 final song1 = Song("So-so", "Artist A", const Duration(minutes: 3, seconds: 30), 2020);
 final song2 = Song("Okay", "Artist B", const Duration(minutes: 4, seconds: 15), 2019);
 final song3 = Song("Another Song", "Artist A", const Duration(minutes: 2, seconds: 45), 2021);
 final song4 = Song("Noyname", "Artist B", const Duration(minutes: 3, seconds: 27), 2022);
 final song5 = Song("Hello!", "Artist C", const Duration(minutes: 2, seconds: 58), 2012);
 final song6 = Song("HAY", "Artist J", const Duration(minutes: 4, seconds: 9), 2017);
 final song7 = Song("Aloha!", "Artist K", const Duration(minutes: 3, seconds: 49), 2012);
 final song8 = Song("Wow!", "Artist A", const Duration(minutes: 3, seconds: 36), 2013);

  final songCollection = [song1, song2, song3, song4, song5, song6, song7, song8];

  final myPlaylist = Playlist("My Playlist", songCollection);

    // Вивести плейлист
  print("Playlist: ${myPlaylist.name}");
  for (final song in myPlaylist.songs) {
    print("Name: ${song.name}, Artist: ${song.artist}, Duration: ${song.duration}, Year: ${song.year}");
  }

  // Пошук та виведення результатів
  const searchQuery = "Artist A";
  final searchResults = myPlaylist.search(searchQuery);
  print("\nSearch results for '$searchQuery':");
  for (final song in searchResults) {
    print("Name: ${song.name}, Artist: ${song.artist}, Duration: ${song.duration}, Year: ${song.year}");
  }

  print("\nSongs total time:");
  print(songCollection.timeSongs());
}
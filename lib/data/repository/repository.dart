import 'package:demo_app_music/data/source/source.dart';

import '../models/Song.dart';

abstract class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();
  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteData) {
      if (remoteData == null) {
        _localDataSource.loadData().then((localData) {
          if (localData != null){
            songs.addAll(localData);
          }
        });
      } else {
        songs.addAll(remoteData);
      }
    });
    return songs;
  }

}
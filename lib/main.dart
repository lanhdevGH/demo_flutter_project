import 'package:demo_app_music/data/repository/repository.dart';
import 'package:flutter/material.dart';

import 'data/models/Song.dart';

void main() async{
  var repo = DefaultRepository();
  List<Song>? songs = await repo.loadData();
  if(songs != null){
    for(var song in songs){
      debugPrint(song.toString());
    }
  }
}

class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/Song.dart';
import 'package:http/http.dart' as http;

abstract class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    try {
      const urlDataSourceStr = 'https://thantrieu.com/resources/braniumapis/songs.json';
      final urlDataSource = Uri.parse(urlDataSourceStr);
      final res =  await http.get(urlDataSource);
      if (res.statusCode == 200){
        //
        final bodyContent = utf8.decode(res.bodyBytes);
        var jsonResponse = jsonDecode(bodyContent) as Map;
        var songListJson = jsonResponse['songs'] as List;
        List<Song> songs = songListJson.map((song) => Song.fromJson(song)).toList();
        //
        return songs;
      } else {
        return null;
      }
    } catch (e){
      debugPrint(e.toString());
    }
  }

}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/songs.json');
      final jsonBody = jsonDecode(response) as Map;
      final listSongJson = jsonBody['songs'] as List;
      List<Song> listSong = listSongJson.map((song) => Song.fromJson(song)).toList();
      return listSong;
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

}
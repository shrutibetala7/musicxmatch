import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'musicModel.dart';

class MusicRepo {
  Future<MusicX> getMusic() async {
    var result = await http.Client().get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=64c31aa4e064d70b5352bec1a5934a5c"));
    if (result.statusCode != 200) {
      throw Exception();
    }
    // debugPrint("\nResult");
    // debugPrint(result.body);
    return parsedJson(result.body);
  }

  MusicX parsedJson(final response) {
    final jsonDecode = json.decode(response);
    // var jsonEncode = json.encode(jsonDecode);
    // debugPrint("\nResponse");
    // debugPrint(jsonDecode.toString());
    return MusicX.fromJson(jsonDecode);
  }

  Future<String> getMusicDetailsB(int trackId) async {
    var result = await http.Client().get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=64c31aa4e064d70b5352bec1a5934a5c"));
    if (result.statusCode != 200) {
      throw Exception();
    }
    return result.body;
  }

  Future<String> getMusicDetailsC(int trackId) async {
    var result = await http.Client().get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=64c31aa4e064d70b5352bec1a5934a5c"));
    if (result.statusCode != 200) {
      throw Exception();
    }
    return result.body;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.http(
      _url,
      '3/movie/now_playing',
      {'api_key': _apikey, 'language': _language},
    );
    final resp = await http.get(url);
    final decodedDate = json.decode(resp.body);
    //procurar cada um dos resultados e criar
    final peliculas = new Peliculas.fromJsonList(
      decodedDate['results'],
    );

    return peliculas.items;
  }
}

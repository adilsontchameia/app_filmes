import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '0799b9f20385bba53b8c36124d57ad7a';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  //Processamento da resposta da api
  Future<List<Pelicula>> _processarResposta(Uri url) async {
    final resp = await http.get(url);
    final decodedDate = json.decode(resp.body);
    //procurar cada um dos resultados e criar
    final peliculas = new Peliculas.fromJsonList(
      decodedDate['results'],
    );

    return peliculas.items;
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.http(
      _url,
      '3/movie/now_playing',
      {'api_key': _apikey, 'language': _language},
    );
    return await _processarResposta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.http(
      _url,
      '3/movie/popular',
      {'api_key': _apikey, 'language': _language},
    );
    return await _processarResposta(url);
  }
}

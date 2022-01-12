import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculasProvider {
  final String _apikey = '0799b9f20385bba53b8c36124d57ad7a';
  final String _url = 'api.themoviedb.org';
  final String _language = 'en-US';

  int _popularesPage = 0;

  //Manejo de stream, corrente de dados
  //Lista de filmes
  List<Pelicula> _populares = [];
  //Stream - codigo de criacao
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  //Processamento da resposta da api
  Future<List<Pelicula>> _processarResposta(Uri url) async {
    final resp = await http.get(url);
    final decodedDate = json.decode(resp.body);
    //procurar cada um dos resultados e criar
    final peliculas = Peliculas.fromJsonList(
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
    _popularesPage++;

    final url = Uri.http(
      _url,
      '3/movie/popular',
      {
        'api_key': _apikey,
        'language': _language,
        'page': _popularesPage.toString(),
      },
    );

    final resp = await _processarResposta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }
}

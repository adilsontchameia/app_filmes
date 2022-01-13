import 'dart:async';
import 'dart:convert';
import 'package:app_filmes/src/models/atores_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculasProvider {
  final String _apikey = '0799b9f20385bba53b8c36124d57ad7a';
  final String _url = 'api.themoviedb.org';
  final String _language = 'en-US';

  int _popularesPage = 0;
  bool _carregando = false;

  //Manejo de stream, corrente de dados
  //Lista de filmes
  final List<Pelicula> _populares = [];
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
    //Nao carregar tudo de uma vez, que pode gastar dados do usuario
    if (_carregando) [];
    _carregando = true;
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
    _carregando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.http(
      _url,
      '3/movie/$peliId/credits',
      {'api_key': _apikey, 'language': _language},
    );
    final resp = await http.get(url);
    //armazenar a resposta do mapa
    final decodedData = json.decode(resp.body);
    final cast = Cast.fromJsonList(decodedData['cast']);
    //vai nos retornar todo cast
    return cast.actores;
  }
}

import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.http(
      _url, 
      '3/movie/now_playing', 
      {
 'api_key' : _api_key,
'language' _language
      });
  }
}

import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/actor_model.dart';
import 'dart:async';
import 'package:peliculas_app/src/models/pelicula_models.dart';
import 'dart:convert';

import 'package:peliculas_app/src/models/reparto_models.dart';

class PeliculasProvider {
  String _url = 'api.themoviedb.org';
  String _apiKey = '142efda4bf0668294e72ef4749947c74';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _peticionHttp(url);
  }

  bool getStatus() => _cargando;

  Future<List<Pelicula>> getPopulars() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _peticionHttp(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> _peticionHttp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Actor>> _peticionHttpActor(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final actores = Actores.fromJsonList(decodedData['cast']);
    return actores.items;
  }

  Future<List<Actor>> getActores(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apiKey, 'language': _language});

    return await _peticionHttpActor(url);
  }

  Future<ActorDetalles> getActorDetalles(String actorId) async {
    final url = Uri.https(
        _url, '3/person/$actorId', {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final actorData = ActorDetalles.toJsonMap(decodedData);
    return actorData;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final resp = await _peticionHttp(url);

    return resp;
  }
}

import 'package:app_filmes/src/pages/home_page.dart';
import 'package:app_filmes/src/pages/pelicula_detalhe.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalhe': (BuildContext context) => PeliculaDetalhe(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app_filmes/src/models/pelicula_model.dart';

class PeliculaDetalhe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Receber os filmes
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments! as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _criarAppBar(pelicula),
        ],
      ),
    );
  }

  Widget _criarAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

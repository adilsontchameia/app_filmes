import 'package:app_filmes/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  MovieHorizontal({required this.peliculas, required this.seguintePagina});

  final List<Pelicula> peliculas;
  final Function seguintePagina;
//Escutar as mudancas do page
  final _pageControler = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  @override
  Widget build(BuildContext context) {
    //20 da tela
    final _screenSize = MediaQuery.of(context).size;

    _pageControler.addListener(() {
      //teste para carregar quando terminar os filmes
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent - 200) {
        //carregando
        seguintePagina();
      }
    });

    return Container(
      height: _screenSize.height * .2,
      //Desenrolar
      child: PageView.builder(
        pageSnapping: true,
        controller: _pageControler,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) =>
            _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage(
                pelicula.getPosterImg(),
              ),
              fit: BoxFit.cover,
              height: 140.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalhe', arguments: pelicula);
      },
    );
  }
}

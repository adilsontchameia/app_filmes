import 'package:app_filmes/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  const MovieHorizontal({required this.peliculas});

  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    //20 da tela
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * .2,
      //Desenrolar
      child: PageView(
        pageSnapping: true,
        children: _tarjetas(context),
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    //percorrer a lista
    return peliculas.map((pelicula) {
      return Container(
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
    }).toList();
  }
}

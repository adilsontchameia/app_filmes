import 'package:app_filmes/src/models/atores_model.dart';
import 'package:app_filmes/src/providers/peliculas_provider.dart';
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
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, pelicula),
            _descricao(pelicula),
            _descricao(pelicula),
            _descricao(pelicula),
            _criarCasting(pelicula),
          ])),
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
          image: NetworkImage(pelicula.getPosterImg()),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                height: 150.0,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis),
                Text(pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString())
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descricao(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _criarCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _criarAtoresPageView(snapshot.data!);
        } else {
          // ignore: prefer_const_constructors
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _criarAtoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
        child: Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          placeholder: const AssetImage('assets/no_avatar.jpeg'),
          fit: BoxFit.cover,
          height: 150.0,
          image: NetworkImage(actor.getFoto()),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        actor.name,
        overflow: TextOverflow.ellipsis,
      )
    ]));
  }
}

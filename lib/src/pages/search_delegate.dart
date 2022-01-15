import 'package:app_filmes/src/models/pelicula_model.dart';
import 'package:app_filmes/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  //api
  final peliculaProvider = PeliculasProvider();

  String selecao = '';

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman1',
    'Ironman2',
    'Ironman3',
    'Captain America'
  ];
  final peliculasRecentes = [
    'Spiderman',
    'Captain America',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Acoes do nosso app bar.
    //exe: icone para limpar o texto

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // algo que aparece no inicio, como icone de pesquisa a esquerda

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        //tempo de duracao
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Instrucao que criar os resultados que mostraremos
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selecao),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sao as sugestoes que vao aparecer ao pesquisar
    //Aplicando Filtro de sugestoes
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: peliculaProvider.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas!.map((peliculas) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'),
                    image: NetworkImage(peliculas.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(peliculas.title),
                  subtitle: Text(peliculas.originalTitle),
                  onTap: () {
                    close(context, null);
                    peliculas.uniqueId = '';
                    Navigator.pushNamed(context, 'detalhe',
                        arguments: peliculas);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });

//Sugestao local
    //  final listaSugerida = (query.isEmpty)
    //       ? peliculasRecentes
    //       : peliculas
    //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
    //           .toList();

    //   return ListView.builder(
    //       itemCount: listaSugerida.length,
    //       itemBuilder: (context, i) {
    //         return ListTile(
    //           leading: Icon(Icons.movie),
    //           title: Text(listaSugerida[i]),
    //           onTap: () {
    //             selecao = listaSugerida[i];
    //             showResults(context);
    //           },
    //         );
    //       });
    // }
  }
}

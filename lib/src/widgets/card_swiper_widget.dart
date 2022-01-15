import 'package:app_filmes/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //Lista de coisas pra se exibir na tela
  //final - porque nao vao mudar
  final List<Pelicula> peliculas;

  // ignore: use_key_in_widget_constructors
  const CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //Otimizar a resolucao de tela
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7, //70%
        itemHeight: _screenSize.height * 0.4, //50%
        itemBuilder: (BuildContext context, int index) {
          //o que vai para heroTag
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalhe',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'),
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },

        //pagination: const SwiperPagination(),
        //control: const SwiperControl(),
      ),
    );
  }
}

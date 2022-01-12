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
        itemHeight: _screenSize.height * 0.5, //50%
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          );
        },

        //pagination: const SwiperPagination(),
        //control: const SwiperControl(),
      ),
    );
  }
}

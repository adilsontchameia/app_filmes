import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //Lista de coisas pra se exibir na tela
  //final - porque nao vao mudar
  final List<dynamic> peliculas;

  const CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //Otimizar a resolucao de tela
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "http://via.placeholder.com/350x150",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 3,
        itemWidth: _screenSize.width * 0.7, //70%
        itemHeight: _screenSize.height * 0.5, //50%

        layout: SwiperLayout.STACK,
        //pagination: const SwiperPagination(),
        //control: const SwiperControl(),
      ),
    );
  }
}

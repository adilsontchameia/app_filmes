import 'package:app_filmes/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('App Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
          child: Column(
        children: [
          criarTarjetas(),
        ],
      )),
    );
  }

  Widget criarTarjetas() {
    return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }
}

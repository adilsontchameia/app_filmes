import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        itemWidth: 200,
        layout: SwiperLayout.STACK,
        //pagination: const SwiperPagination(),
        //control: const SwiperControl(),
      ),
    );
  }
}

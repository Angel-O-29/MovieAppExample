import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/src/widgets/horizontal_page_view.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peli-Info'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, delegate: DataSearch(),
                  //query = '' esto es el valor inicias
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swiperTarjetas(), _footer(context)],
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return (snapshot.hasData)
            ? SwiperWidget(
                peliculas: snapshot.data,
                assetsImage: 'assets/no-image.jpg',
              )
            : Container(
                child: Center(child: CircularProgressIndicator()),
                height: 400.0,
              );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                return (snapshot.hasData)
                    ? HorizontalPageViewWidget(
                        peliculas: snapshot.data,
                        siguientePagina: peliculasProvider.getPopulars,
                      )
                    : Container(
                        height: 160.0,
                        child: Center(child: CircularProgressIndicator()));
              })
        ],
      ),
      width: double.infinity,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_models.dart';

class SwiperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final String assetsImage;

  SwiperWidget({@required this.peliculas, this.assetsImage});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.0),
      height: _screenSize.width * 0.8,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-cardSwiper';
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'detalles',
                  arguments: peliculas[index]);
            },
            child: Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FadeInImage(
                  placeholder: AssetImage(assetsImage),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        curve: Curves.easeIn,
        layout: SwiperLayout.STACK,
        //autoplay: true,
        //autoplayDelay: 10000, // en milisegundos
        itemWidth: _screenSize.width * 0.5,
        itemCount: 10,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}

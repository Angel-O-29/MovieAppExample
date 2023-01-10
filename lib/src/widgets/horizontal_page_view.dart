import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_models.dart';

class HorizontalPageViewWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  HorizontalPageViewWidget(
      {@required this.peliculas, @required this.siguientePagina});
  final _pageController =
      new PageController(viewportFraction: 0.3, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        //print('cargar pelis');
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) =>
            _tarjeta(context, peliculas[i]),
        pageSnapping: false,
        controller: _pageController,
      ),
    );
  }

  _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalles', arguments: pelicula);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 160.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
  /*List<Widget> _tarjetas(BuildContext context) => peliculas
      .map((pelicula) => Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    height: 160.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  pelicula.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ))
      .toList();*/

}

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_models.dart';
import 'package:peliculas_app/src/models/reparto_models.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class PeliculaDetallesPage extends StatelessWidget {
  const PeliculaDetallesPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitle(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _crearCasting(pelicula),
          ]))
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackImg()),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(Pelicula pelicula, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 150.0,
                ),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border),
                      Text(
                        pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ));
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: (pelicula.overview.length == 0)
          ? Text('Aun no se encuentra disponible una descripcion')
          : Text('${pelicula.overview}'),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) => SizedBox(
        height: 200.0,
        child: PageView.builder(
            controller: PageController(initialPage: 1, viewportFraction: 0.3),
            itemCount: actores.length,
            pageSnapping: false,
            itemBuilder: (BuildContext context, int i) =>
                _actorTarjeta(context, actores[i])),
      );

  _actorTarjeta(BuildContext context, Actor actor) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'actor detalles', arguments: actor);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.getfoto()),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              actor.name,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

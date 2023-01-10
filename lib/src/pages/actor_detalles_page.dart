import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/models/reparto_models.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class ActorDetallesPage extends StatelessWidget {
  final peliProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    final Actor _actor = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: 25.0,
            ),
            FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 2.0,
              expandedHeight: 450.0,
              leading: Container(),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 10.0),
                title: Text(_actor.name,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[350])),
                background: FadeInImage(
                  image: NetworkImage(_actor.getfoto()),
                  placeholder: AssetImage('assets/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 200),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _infoActor(_actor),
            ])),
          ],
        ),
      ),
    );
  }

  Widget _infoActor(Actor actor) {
    return FutureBuilder(
        future: peliProvider.getActorDetalles(actor.id.toString()),
        builder:
            (BuildContext context, AsyncSnapshot<ActorDetalles> snapshot) =>
                (snapshot.hasData)
                    ? _infoWidget(snapshot.data, context)
                    : Container(
                        height: 200.0,
                        child: Center(child: CircularProgressIndicator())));
  }

  _infoWidget(ActorDetalles actorDetalles, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _cumple = (actorDetalles.birthday != null)
        ? actorDetalles.birthday
        : 'no disponible';
    final _muerte =
        (actorDetalles.deathday != null) ? actorDetalles.deathday : '---';
    final _birthPlace = (actorDetalles.placeOfBirth != null)
        ? actorDetalles.placeOfBirth
        : 'no disponible';
    final _genero = (actorDetalles.gender == 1) ? 'mujer' : 'hombre';
    final _bio = (actorDetalles.biography.length == 0)
        ? 'Biografia no Disponible'
        : actorDetalles.biography;
    return Container(
      height: _screenSize.height * 0.8,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Fecha de Nacimiento: $_cumple ',
          ),
          SizedBox(
            height: 5.0,
          ),
          Text('Lugar de nacimiento : $_birthPlace'),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Genero: $_genero '),
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow[800],
                  ),
                  Text(
                    actorDetalles.popularity.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'fecha de fallecimiento: $_muerte',
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(_bio),
          )
        ],
      ),
    );
  }
}

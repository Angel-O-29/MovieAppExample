import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_models.dart';

class VerticalListViewWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function closeFunction;
  const VerticalListViewWidget(
      {Key key, @required this.peliculas, @required this.closeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _listTile(peliculas, context),
    );
  }

  List<Widget> _listTile(List<Pelicula> peliculas, BuildContext context) =>
      peliculas
          .map((e) => ListTile(
                leading: FadeInImage(
                  image: NetworkImage(e.getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  height: 70.0,
                ),
                onTap: () {
                  closeFunction();
                  e.uniqueId = '';
                  Navigator.pushNamed(context, 'detalles', arguments: e);
                },
                title: Text(e.title),
                subtitle: Text(e.originalTitle),
              ))
          .toList();
}

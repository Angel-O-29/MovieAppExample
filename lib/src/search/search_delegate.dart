import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_models.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/widgets/vertical_list_view.dart';

class DataSearch extends SearchDelegate {
  /*
  final peliculas = [
    'spiderman',
    'capitan america',
    'saw',
    'servidor',
    'aquaman',
    'batman',
    'comedia romantica generica'
  ];
  final peliculasRecientes = [
    'spiderman',
    'capitan america',
    'saw',
    'servidor'
  ];
  String seleccion = '';*/
  final _peliProvider = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda
    return IconButton(
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados cuando le hacen clic a un elemento del build sugestion
    return Container();
    /*Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.green,
      child: Text(seleccion),
    ))*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: _peliProvider.buscarPeliculas(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) =>
                (snapshot.hasData)
                    ? VerticalListViewWidget(
                        peliculas: snapshot.data,
                        closeFunction: () => close(context, null),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
      );
    }
  }

/*
  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe

    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((element) => element.toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context); esto es para poder mostrar resultados con build results
          },
        );
      },
    );
  }
*/
}

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/actor_detalles_page.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/pelicula_detalles_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.indigo,
          dividerColor: Colors.indigo[900],
          accentColor: Colors.indigoAccent[100],
          splashColor: Colors.purple[100],
          appBarTheme: AppBarTheme(color: Colors.indigoAccent)),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalles': (BuildContext context) => PeliculaDetallesPage(),
        'actor detalles': (BuildContext context) => ActorDetallesPage(),
      },
    );
  }
}

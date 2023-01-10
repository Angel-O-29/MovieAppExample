import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  const BasicoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _placeImage(),
            _placeName(context),
            _actionsButtons(context),
            _textInfo(),
            _textInfo(),
            _textInfo(),
            _textInfo(),
          ],
        ),
      ),
    );
  }

  Widget _placeImage() => FadeInImage(
        height: 250.0,
        width: double.infinity,
        placeholder: AssetImage('assets/loading.gif'),
        image: NetworkImage(
            'https://miro.medium.com/max/1000/1*qomnLD1SsPKG6_bQZth5qg.jpeg'),
        fit: BoxFit.fill,
      );

  _placeName(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medanos de Coro',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Edo Falcon, Venezuela',
                      style: TextStyle(color: Colors.grey))
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange[900],
                      size: 30.0,
                    ),
                    Text(
                      '42',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _actionsButtons(BuildContext context) => Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _actions(
                context,
                Icon(
                  Icons.call,
                  color: Colors.blue,
                  size: 30.0,
                ),
                'CALL'),
            _actions(
                context,
                Icon(
                  Icons.map,
                  color: Colors.blue,
                  size: 30.0,
                ),
                'ROUTE'),
            _actions(
                context,
                Icon(
                  Icons.share,
                  color: Colors.blue,
                  size: 30.0,
                ),
                'SHARE'),
          ],
        ),
      );

  Widget _actions(BuildContext context, Icon icon, String text) =>
      GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, 'scroll');
        },
        child: Column(
          children: [
            icon,
            SizedBox(
              height: 5.0,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15.0, color: Colors.blue),
            )
          ],
        ),
      );

  Widget _textInfo() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Text(
              'El parque nacional Los Médanos de Coro es un parque nacional ubicado en el estado Falcón, en la jurisdicción de los municipios Miranda, Colina y Falcón, en el noroeste de Venezuela. Su área más importante está circunscrita alrededor del istmo, en la vía a la Península de Paraguaná al costado norte de la ciudad de Santa Ana de Coro. El istmo comprende una faja de 30 km de largo por 5 km de ancho.',
              textAlign: TextAlign.justify,
            ),
            Text(
              ' Los Médanos de Coro son formaciones de arena características del relieve del estado Falcon, siendo este parte del sistema Lara-Falcón por sus dunas que sobrepasan los 8 msnm. Este parque nacional preserva el área protegida más cercana al Golfo de Venezuela.',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );
}

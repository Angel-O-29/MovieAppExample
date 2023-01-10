import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ComplejoPage extends StatelessWidget {
  const ComplejoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgrondImage(),
          _content(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (i) {
          //print(i);
          Navigator.pushReplacementNamed(context, 'basico');
        },
        unselectedIconTheme:
            IconThemeData(color: Color.fromRGBO(92, 93, 126, 1.0)),
        selectedIconTheme:
            IconThemeData(color: Color.fromRGBO(236, 98, 188, 0.7)),
        backgroundColor: Color.fromRGBO(55, 56, 85, 1.0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
            //activeIcon: Text('slsdf')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: '')
        ],
      ),
    );
  }

  Widget _backgrondImage() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(52, 54, 101, 1.0),
          Color.fromRGBO(35, 37, 57, 1.0)
        ], begin: FractionalOffset(0.0, 0.6), end: FractionalOffset(0.0, 1.0)),
      ),
    );
    final cajaRosa = Transform.rotate(
        angle: 45.0 * (pi / 180.0),
        child: Container(
          height: 400.0,
          width: 400.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(241, 142, 172, 1.0),
                    Color.fromRGBO(236, 98, 188, 1.0),
                  ],
                  begin: FractionalOffset(0.3, 0.3),
                  end: FractionalOffset(0.7, .7)),
              borderRadius: BorderRadius.circular(80.0)),
        ));
    return Stack(
      children: [
        gradiente,
        Positioned(
          child: cajaRosa,
          top: -120.0,
          left: -50.0,
        )
      ],
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_texto(context), _gridButtons(context)],
          ),
        ),
      ),
    );
  }

  Widget _texto(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    //print(_screenSize.height);
    final _height = (_orientation.index == 0)
        ? _screenSize.height * 0.23
        : _screenSize.height * 0.3;
    final _description = (_screenSize.height >= 357)
        ? Text(
            'Classify this transaction into a particular category',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w300),
            overflow: TextOverflow.clip,
          )
        : Container();
    return Container(
      height: _height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Classify transaction',
          style: TextStyle(
              color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20.0,
        ),
        _description
      ]),
    );
  }

  Widget _gridButtons(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    final _row = (_orientation.index == 0) ? 2 : 3;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        width: double.infinity,
        height: _screenSize.height * 0.62,
        child: GridView.count(
          crossAxisCount: _row,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            _gridCard(Icons.face, Colors.blueAccent, 'General'),
            _gridCard(Icons.face, Colors.purpleAccent, 'Transport'),
            _gridCard(Icons.face, Colors.pink, 'Shopping'),
            _gridCard(Icons.face, Colors.orangeAccent, 'Bills'),
            _gridCard(Icons.face, Colors.blue[300], 'Entretaiment'),
            _gridCard(Icons.face, Colors.green, 'General'),
            _gridCard(Icons.face, Colors.redAccent, 'Fu'),
            _gridCard(Icons.face, Colors.grey, 'Cancel'),
          ],
        ),
      ),
    );
  }

  Widget _gridCard(IconData icon, Color color, String text) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SingleChildScrollView(
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color.fromRGBO(62, 66, 107, 0.7)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _iconCircular(icon, color),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20.0, color: color),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _iconCircular(IconData icon, Color color) => Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100.0)),
        padding: EdgeInsets.all(20.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
      );
  /*metodo para perzonalizar ful el bottomnavigatorbar
  Widget _bottomNavigatorBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0), //color de fondo
        primaryColor: Colors.pinkAccent, //color de un boton seleccionado
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color:Color.fromRGBO(92, 93, 126, 1.0) )//el color de los elementos no seleccionados
        )
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
            //activeIcon: Text('slsdf')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: '')
        ],
      ),
    );
  }*/
}

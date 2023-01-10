import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      children: [
        _pagina1(),
        _pagina2(context),
      ],
    ));
  }

  Widget _pagina1() => Stack(
        children: [_colorFondo(), _fondoImagen(), _contenidoPage()],
      );

  Widget _pagina2(BuildContext context) => Stack(
        children: [_colorFondo(), _actionbutton(context)],
      );

  Widget _colorFondo() => Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(108, 192, 218, 1.0),
      );

  Widget _fondoImagen() => Container(
        height: double.infinity,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/scroll.png'),
          fit: BoxFit.fill,
        ),
      );

  Widget _contenidoPage() {
    final styleText = TextStyle(color: Colors.white, fontSize: 40.0);
    return Container(
      padding: EdgeInsets.only(top: 35.0, bottom: 25.0),
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              '11°',
              style: styleText,
            ),
            Text(
              'Miércoles',
              style: styleText,
            ),
            Expanded(child: SizedBox()),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 70.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _actionbutton(BuildContext context) => Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'complejo');
          },
          textColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Text(
              'Bienvenido',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          color: Colors.blue,
          shape: BeveledRectangleBorder(
              side: BorderSide(
                style: BorderStyle.solid,
                color: Colors.blue[300],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
        ),
      );
}

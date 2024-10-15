import 'package:flutter/material.dart';

class pagina_principal extends StatefulWidget {

  const pagina_principal({Key? key}) : super(key: key);

  @override
  _pagina_principalState createState() => _pagina_principalState();

}

class _pagina_principalState extends State<pagina_principal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Text('Bienvenido a Muffin Study'),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AlimentarPage extends StatefulWidget {

  @override
  State<AlimentarPage> createState() => _AlimentarPageState();
}

class _AlimentarPageState extends State<AlimentarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('aqui se va a alimentar los peces'),),
    );
  }
}
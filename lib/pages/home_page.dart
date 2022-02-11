import 'package:flutter/material.dart';

import 'package:fishs_app/models/horario.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Horario> horarios = [
    Horario(cantidadComida: 600, hora: '06:00 am', uid: '15263'),
    Horario(cantidadComida: 600, hora: '04:00 pm', uid: '15263'),
    Horario(cantidadComida: 600, hora: '17:00 pm', uid: '15263'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          'AppFishs',
          style: TextStyle(color: Colors.black87, fontSize: 20.0),
        ),
      ),
      body: myBody(context),
    );
  }

  Column myBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //  TODO: en este container va la grafica en tiempo real del recipiente
          height: 300.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Horario de alimentación',
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
        Divider(
          height: 15.0,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, i) => rowHorario(horarios[i]),
            itemCount: horarios.length,
            // quitar las manchas azules que indican que está en una lista
            physics: const ScrollPhysics(),
          ),
        ),
        rowBotonesAccion(context),
        Divider(height: 100.0)
      ],
    );
  }

  Row rowBotonesAccion(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // MaterialButton(
        //   textColor: Colors.white,
        //   color: Colors.blue,
        //   child: Text(
        //     'Alimentar ya',
        //     style: TextStyle(fontSize: 22.0),
        //   ),
        //   // cuando se presione navegar a las pantalla de alimentar
        //   onPressed: () {
        //     Navigator.pushNamed(context, 'alimentar');
        //   }
        // ),
        MaterialButton(
          textColor: Colors.white,
          child: Text(
            'configurar',
            style: TextStyle(fontSize: 22.0),
          ),
          color: Colors.blue,
          // navegar a la pantalla donde se programarán los horarios
          onPressed: () {
            Navigator.pushNamed(context, 'configurar');
          }
        ),
      ],
    );
  }

  Widget rowHorario(Horario horario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 2.0),
      child: ListTile(
        leading: Icon(Icons.alarm_on_outlined, color: Colors.greenAccent[700],),
        tileColor: Colors.blue[100],
        title: Text(horario.hora),
        trailing: Text('${horario.cantidadComida} gr'),        
      ),
    );
  }

  
}

import 'package:flutter/material.dart';


mostrarAlerta(BuildContext context, String titulo, String subtitulo){
  showDialog(
    context: context,
    builder: ( _ ) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.error_sharp, color: Colors.amber,),
          SizedBox(width: 5.0,),
          Text(titulo),
        ],
      ),
      content: Text(subtitulo),
      actions: <Widget>[
          MaterialButton(
          child: Text('Ok'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context)
        )
      ],
    )
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:fishs_app/global/environment.dart';
import 'package:fishs_app/models/horario.dart';
import 'package:fishs_app/models/horario_response.dart';



class NewServices with ChangeNotifier{

  Horario? horario;

  bool _autenticando = false;

  bool get autenticando=>this._autenticando;

  set autenticando(bool valor){
    this._autenticando = valor;
    //notifica a todos los que estan escuchando esta propiedad 
    // para que se redibujen
    notifyListeners();
  }

  Future<bool?> newHorario(String hora, int CantidadComida) async {

    this.autenticando = true;

    final data = {
      "hora": hora,
      "cantidadComida": CantidadComida
    };
      
    final resp = await http.post( Uri.parse('${Environment.apiUrl}/creacion/new'),
      body: jsonEncode(data),

      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    this.autenticando = false;

    if(resp.statusCode == 200){
      final horaioResponse = horarioResponseFromJson(resp.body); 
      this.horario = horaioResponse.horario;


      return true;
    } else {
      return false;
    }
  }
}
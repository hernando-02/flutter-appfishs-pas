// To parse this JSON data, do
//
//     final horario = horarioFromJson(jsonString);

import 'dart:convert';

Horario horarioFromJson(String str) => Horario.fromJson(json.decode(str));

String horarioToJson(Horario data) => json.encode(data.toJson());

class Horario {
    Horario({
        required this.hora,
        required this.cantidadComida,
        required this.uid,
    });

    String hora;
    int cantidadComida;
    String uid;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        hora: json["hora"],
        cantidadComida: json["cantidadComida"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "hora": hora,
        "cantidadComida": cantidadComida,
        "uid": uid,
    };
}

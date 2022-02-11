// To parse this JSON data, do
//
//     final horarioResponse = horarioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fishs_app/models/horario.dart';

HorarioResponse horarioResponseFromJson(String str) => HorarioResponse.fromJson(json.decode(str));

String horarioResponseToJson(HorarioResponse data) => json.encode(data.toJson());

class HorarioResponse {
    HorarioResponse({
        required this.ok,
        required this.horario,
    });

    bool ok;
    Horario horario;

    factory HorarioResponse.fromJson(Map<String, dynamic> json) => HorarioResponse(
        ok: json["ok"],
        horario: Horario.fromJson(json["horario"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "horario": horario.toJson(),
    };
}


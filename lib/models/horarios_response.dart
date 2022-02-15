// To parse this JSON data, do
//
//     final horariosResponse = horariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fishs_app/models/horario.dart';

HorariosResponse horariosResponseFromJson(String str) => HorariosResponse.fromJson(json.decode(str));

String horariosResponseToJson(HorariosResponse data) => json.encode(data.toJson());

class HorariosResponse {
    HorariosResponse({
        required this.ok,
        required this.horarios,
    });

    bool ok;
    List<Horario> horarios;

    factory HorariosResponse.fromJson(Map<String, dynamic> json) => HorariosResponse(
        ok: json["ok"],
        horarios: List<Horario>.from(json["horarios"].map((x) => Horario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    };
}


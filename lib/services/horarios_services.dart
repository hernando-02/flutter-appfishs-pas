import 'package:http/http.dart' as http;

import 'package:fishs_app/global/environment.dart';

import 'package:fishs_app/models/horario.dart';
import 'package:fishs_app/models/horarios_response.dart';

class HorariosServices {
  Future<List<Horario>> getHorarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/horarios'),
        headers: {
          'Content-Type': 'application/json'
        }
      );

      final horarioResponse = horariosResponseFromJson(resp.body);
      // print(horarioResponse.horarios);

      return horarioResponse.horarios;
    } catch (e) {
      return [];
    }
  }
}

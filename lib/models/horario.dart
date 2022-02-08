

class Horario{

  String id;
  String hora;
  int usado;
  int cantidadComida;

  Horario({
    this.id = '',
    this.hora = "",
    this.usado = 0,
    this.cantidadComida = 0,
  });

  factory Horario.fromMap(Map<String, dynamic> obj) 
    => Horario(
      id: obj['id'],
      hora:   obj['hora'],
      usado:  obj['usado'],
      cantidadComida: obj['cantidadComida'],
    );
}


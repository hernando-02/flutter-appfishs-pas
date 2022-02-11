 
// esta sera una clase solo tendra solo metodo estaticos 
// esto con el fin de poder acceder a ellos si necesidad de
// instanciar la clase

import 'dart:io';

class Environment{

   // servicios REST
  static String apiUrl    = Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';
  // servidor de socket 
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000'     : 'http://localhost:3000';
  
}
 
// esta sera una clase solo tendra solo metodo estaticos 
// esto con el fin de poder acceder a ellos si necesidad de
// instanciar la clase

import 'dart:io';

class Environment{

   // ? servicios REST PRODUCCION
  static String apiUrl    = Platform.isAndroid ? 'https://fishs-ap-restserver.herokuapp.com/api' : 'https://fishs-ap-restserver.herokuapp.com/api';
  
  // ! Servicios REST  desarrollo
  // static String apiUrl    = Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';


  // servidor de socket 
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000'     : 'http://localhost:3000';
  
}
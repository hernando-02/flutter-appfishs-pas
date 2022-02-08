
import 'package:fishs_app/pages/alimentar_page.dart';
import 'package:fishs_app/pages/confi_horario_page.dart';
import 'package:flutter/material.dart';

import 'package:fishs_app/pages/home_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {

  'home': ( _ )=> HomePage(),
  'configurar': ( _ ) => HorarioConfi(),
  'alimentar' : ( _ ) => AlimentarPage()
};
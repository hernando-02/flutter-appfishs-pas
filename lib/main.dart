import 'package:fishs_app/services/new_service.dart';
import 'package:flutter/material.dart';


import 'package:fishs_app/routes/routes.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => NewServices())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App fish',
        initialRoute: 'home',
        // configurar
        // home
        routes: appRoutes
      ),
    );
  }
}
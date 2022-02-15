import 'package:fishs_app/services/horarios_services.dart';
import 'package:flutter/material.dart';

import 'package:fishs_app/models/horario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final horarioService = new HorariosServices();

  List<Horario> horarios = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarHorarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          'AppFish: Alimenta tus peces',
          style: TextStyle(color: Colors.black87, fontSize: 20.0),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarHorarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green[600],),
          waterDropColor: Colors.green,
        ),
        child: myBody(context),
      ),
    );
  }

  Column myBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //  TODO: en este container va la grafica en tiempo real del recipiente
          height: 300.0,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Expanded(
              child: Container(
                color: Colors.green[600],
                height: 45.0,
                child: Center(
                  child: Text(
                  'Horario de alimentación',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(height: 5.0, color: Colors.white,),
      
        Expanded(
          child: ListView.separated(

            
            separatorBuilder: (_, i)=>Divider(height: 5.0,),
            itemBuilder: (context, i) => rowHorario(horarios[i]),
            itemCount: horarios.length,
            // quitar las manchas azules que indican que está en una lista
            physics: const ScrollPhysics(),
          ),
        ),
        Container(
          width: 500,
          height: 65.0,
          color: Colors.white,
          child: rowBotonesAccion(context)
        ),
        // Divider(height: 100.0)
      ],
    );
  }

  Row rowBotonesAccion(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // MaterialButton(
        //   textColor: Colors.white,
        //   color: Colors.blue,
        //   child: Text(
        //     'Alimentar ya',
        //     style: TextStyle(fontSize: 22.0),
        //   ),
        //   // cuando se presione navegar a las pantalla de alimentar
        //   onPressed: () {
        //     Navigator.pushNamed(context, 'alimentar');
        //   }
        // ),
        MaterialButton(
          textColor: Colors.white,
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 10.0,),
              Text(
                'Configurar',
                style: TextStyle(fontSize: 22.0),
              ),

            ],
          ),
          color: Colors.green[600],
          // navegar a la pantalla donde se programarán los horarios
          onPressed: () {
            Navigator.pushNamed(context, 'configurar');
          }
        ),
      ],
    );
  }

  Widget rowHorario(Horario horario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.0),
      child: ListTile( 
        leading: Icon(Icons.alarm_on_outlined, color: Colors.greenAccent[700],),
        tileColor: Colors.blue[100],
        title: Text(horario.hora),
        trailing: Text('${horario.cantidadComida} gr'),        
      ),
    );
  }

  _cargarHorarios() async{


    this.horarios = await horarioService.getHorarios();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }


  
}

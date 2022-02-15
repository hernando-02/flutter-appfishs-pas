import 'package:fishs_app/helpers/mostrar_alerta.dart';
import 'package:fishs_app/services/horarios_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fishs_app/services/new_service.dart';
// import 'package:intl/intl.dart';

import 'package:fishs_app/models/horario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HorarioConfi extends StatefulWidget {
  @override
  State<HorarioConfi> createState() => _HorarioConfiState();
}

class _HorarioConfiState extends State<HorarioConfi> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final horarioService = new HorariosServices();


  // ! esto es para hacer pruebas
  List<Horario> horarios = [];

  final ctrlComida = TextEditingController();
  
  // var _time;
  // var timeStamp;
  // var anotherDate;
  // var newDateTime;
  var selectedDate;
  var selectedTime;

  @override
  void initState() {
    super.initState();
    // _time = DateTime.now();
    // timeStamp = _time.millisecondsSinceEpoch;
    // anotherDate = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    // anotherDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(_time);
    // newDateTime = DateTime.parse(anotherDate);
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
   _cargarHorarios();    
  }

  // _selectedDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context, 
  //     initialDate: selectedDate, 
  //     firstDate: DateTime(2000), 
  //     lastDate: DateTime(2025)
  //   );
  //   if(picked != null && picked != selectedDate){
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }
  _selectedTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
     
    );
    if(picked != null && picked != selectedTime){
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Horario',
          style: TextStyle(color: Colors.black87, fontSize: 20.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarHorarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green[600],),
          waterDropColor: Colors.green,
        ),
        child:bodyColumn(context) ,
      ),
    );
  }

  Column bodyColumn(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _formNuevoHorario( context),
        Divider(height: 1.0,),
        listHorarios(),
      ],
    );
  }

  Container _formNuevoHorario( context) {

    // TODO: puede dar posible error
    final newService = Provider.of<NewServices>(context);


    return Container(
      color: Colors.white,
      height: 290.0,
      child: Column(
        children: <Widget>[
        SizedBox(height: 40.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Agregar nueva hora de alimentación',
              style: TextStyle(fontSize: 22.0),)
            ],
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Seleccionar hora',
              style: TextStyle(fontSize: 22.0),
            ),
            onPressed: (){
              // print('${_time}');
              // _selectedDate(context);
              _selectedTime(context);
              convertirDateTimeToString(selectedTime);
            }
          ),
          // Container(height: 50.0, child: Text('${newDateTime}')),
          /* 
          * * así se selecciona la fecha
          Container(height: 50.0, child: Text('${DateFormat('dd/MM/yyyy').format(selectedDate)}')),
           */
          Container(
            color: Colors.blue[100], 
            height: 50.0, 
            width: 198.0, 
            child: Center(
            child: 
              Text('${selectedTime.hour} : ${selectedTime.minute}',
                style: TextStyle(fontSize: 22.0),
              ),
          )),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Ingrese cantidad de alimento (gr)',
                style: TextStyle(fontSize: 22.0),
              ),
            ],
          ),
          Container(
            width: 198.0,
            height: 50.0,
            // color: Colors.green,
            child: TextFormField(
              style: TextStyle(color: Colors.black87, fontSize: 22.0),
              controller: ctrlComida,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0)
                )
              ),
            )
          ),
          
          // ? este esl el boton que crea la nueva hora de alimentación
          MaterialButton(
            minWidth: 198.0,
            color: Colors.green[600],
            textColor: Colors.white,
            child: Text('Añadir al horario',
              style: TextStyle(fontSize: 22.0),
            ),
            onPressed: newService.autenticando? null : () async {

              /* 
                TODO: asegurarme que vaya informacion en la caja de texto de la cantidad de comida
              */

              FocusScope.of(context).unfocus();

              final loginOk = await newService.newHorario(convertirDateTimeToString(selectedTime), int.parse(ctrlComida.text.trim()) );
              if(loginOk != null && loginOk){
                // mostrar el horario nuevo en la lista
                addNewHorarioToList( convertirDateTimeToString(selectedTime) , int.parse(ctrlComida.text));
              } else {
                // mostrar alerta 
                mostrarAlerta(context, 'Error', 'Esta hora ya está programada');
              }

            }
          ),
        ],
      ),      
    );
  }

  // Flexible listHorarios() {
  //   return Flexible(
  //       child: Container(
  //         // color: Colors.amber,
  //         // height: 350.0,
  //         child:  ListView.builder(
  //           itemBuilder: (context, i) => rowHorario(horarios[i]) ,
  //           itemCount: horarios.length,
  //           // quitar las manchas azules que indican que está en una lista
  //           physics: const ScrollPhysics(),
  //         ),
  //       ),
  //     );
  // }

  Widget listHorarios() {
    return Expanded(
      child: 
        ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return _rowHorario(index);
          },
          itemCount: horarios.length,
          // quitar las manchas azules que indican que está en una lista
          physics: const ScrollPhysics(),
        ),  
    );
  }
  Widget _rowHorario(int index) {
    return Dismissible(
      onDismissed: (direction){
        setState(() {
          horarios.removeAt(index);
        });
      },
      key: Key(horarios[index].uid),
      background: Column(
        children: [
          Container(height: 2.0,),
          Container(height: 57.0,
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Row(
                children: [
                  Icon(Icons.delete_forever, color: Colors.white,),
                  Text('Eliminar Hora', style: TextStyle(color: Colors.white), ),
                ],
              ),
            ),
          ),),
          Container(height: 2.0,),
          
        ],
      ),
      // key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10.0),
        child: ListTile(
          leading: Icon(
            Icons.alarm_on_outlined,
            color: Colors.greenAccent[700],
          ),
          tileColor: Colors.blue[100],
          title: Text(horarios[index].hora),
          trailing: Text('${horarios[index].cantidadComida} gr'),
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.alarm_on_outlined,
        //     color: Colors.greenAccent[700],
        //   ),
        //   tileColor: Colors.blue[100],
        //   title: Text(horarios[index].hora),
        //   trailing: Text('${horarios[index].cantidadComida} gr'),
        // ),
      ),
    );
  }

  addNewHorarioToList( String hora, int cantidadComida) {
    if(hora.length > 0  && cantidadComida > 0){
      // int canComida = int.parse()
      this.horarios.add(new Horario(uid: DateTime.now().toString(),cantidadComida:cantidadComida, hora: hora ));
      setState(() { });
    }
  }

  String convertirDateTimeToString( TimeOfDay dateTime){
   
    // * 1. convertir el selectedTime.hour en String
    String hora= selectedTime.hour.toString();
    // * 2. convertir a int
    int horaInt = int.parse(hora);

    String minuto = selectedTime.minute.toString();
    int minuInt = int.parse(minuto);

    //  saber si es am o pm
    String amPm = "";
    if(horaInt >= 12){
      amPm = 'PM';
    }else{
      amPm = 'AM';
    }

    // minutos menores que 10
    if(minuInt <10){
      minuto = '0${minuInt}';
    }else{
      minuto = '${minuInt}';
    }    
    
    String time = '${selectedTime.hour}:${minuto}:00';
    
    if(horaInt < 10) {
      time = '0${selectedTime.hour}:${minuto}:00';

    }
    return time;
  }

  _cargarHorarios() async{


    this.horarios = await horarioService.getHorarios();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

}

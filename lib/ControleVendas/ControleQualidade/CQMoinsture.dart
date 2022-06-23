import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelMoisture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:data_table_2/data_table_2.dart';
import 'package:atcsearch/Quality2/ConsultaCostumer.dart';

import 'ControleQualidade.dart';

class CQMoinsture extends StatefulWidget {
  String? valor, valor1, valor2;

  CQMoinsture({this.valor, this.valor1, this.valor2});

  @override
  _CQMoinstureState createState() => _CQMoinstureState();
}

class _CQMoinstureState extends State<CQMoinsture> {
  late Future<List<ModelMoisture>> _myData = _recuperarPostagens(0);
  late TextEditingController safra;
  late TextEditingController grade;
  late TextEditingController cliente;
  int n = -1; // 0 para deixar selecionada a prinmeira linha e -1 para nenhuma no datable
  int x = 0;
  bool checked = false;
  List<int> selectedRow = [];

  //double mediaNicotine  = 0;
  //double mediaSugar  = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    safra = TextEditingController();
    grade = TextEditingController();
    cliente = TextEditingController();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    safra.text = formatted.toString();
    grade.text = "0000";

    setState(() {
      if (widget.valor != null) {
        grade.text = "${widget.valor}";
        safra.text = "${widget.valor2}";
        //VALOR = COD_GRADE
//VALOR1 = DES_GRADE
        //VALOR2 = SAFRA

        //Consultar banco de dados

      } else {
        widget.valor1 = "0000";
      }
    });
  }

  onSelectedRow(bool? selected, int index) async {
    setState(() {
      if (selected == true) {
        selectedRow.add(index);
      } else {
        selectedRow.remove(index);
      }
    });
  }

  bool setVisible() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return true; // is portrait
    } else {
      return false; // is landscape
    }
  }

  Future<List<ModelMoisture>> _recuperarPostagens(int n) async {
    String url = "http://192.168.200.11/read.php?tipo=moinsture&safra=" +
        safra.text +
        "&grade=" +
        grade.text;
    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    List<ModelMoisture> postagens = <ModelMoisture>[];
    for (var post in dadosJson) {
      setState(() {
        cliente.text = post["des_pessoa"];
      });
      ModelMoisture p = ModelMoisture(
          post["sampledate"],
          post["shift"],
          post["box"],
          post["sampletime"],
          post["casefirst"],
          post["caselast"],
          post["blending"],
          post["brabender"],
          post["oven"],
          post["coolerr"],
          post["coolerl"],
          post["bthresh"],
          post["stem"],
          post["tips"],
          post["ptemp"],
          post["out_crop"],
          post["des_grade"],
          post["method"],
          post["product"],
          post["pm1"],
          post["pm2"],
          post["pm3"],
          post["pm4"],
          post["pm5"],
          post["pm6"],
          post["pm7"],
          post["pm8"],
          post["pm9"],
          post["pm10"],
          post["pm11"],
          post["pm12"]);
      postagens.add(p);
    }
    //print( postagens.toString() );

    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown, //Forçar orientação da tela
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Moisture",
        theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: AppBarTheme(
        // backgroundColor: Colors.black,
        //foregroundColor: Colors.white, //here you can give the text color
    )
    //accentColor: Colors.orange,

    ),
    home: Scaffold(
    appBar: AppBar(
    leading: BackButton(
    color: Colors.white,
    onPressed: () {
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => ControleQualidade()));
    }),
    title: Text(
    "Moisture",
    ),
    //backgroundColor: Colors.black,
    ),
    body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: setVisible(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Codigo: " + grade.text + " Safra: " + safra.text,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Cliente: " + cliente.text,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ),
            ),
            Visibility(
              visible: setVisible(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          "Grade: ${widget.valor1}",
                          style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.5
                              ..color = Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),

                    /*  Expanded(

                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 110, 0),
                     child: GestureDetector(
                       child: Container(
                         //color: Colors.yellow,
                         width: 80.0,
                         height: 40.0,
                         child: Icon(Icons.search, size: 30,),
                       ),
                       onTap: () {

                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                             builder: (_) => ConsultaCostumer(),
                           ),
                         );

                       },
                     ),



                      /*IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.search),
                        onPressed: (){ Navigator.pushReplacement(
                                                             context,
                                                 MaterialPageRoute(
                                                   builder: (_) => ConsultaCostumer(),
                                               ),
                                                   );
                                               }
                   ),*/
                  ),
                  ),*/
                  ],
                ),
              ),
            ),
            Visibility(
              visible: setVisible(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConsultaCostumer(
                                    interface: "CQMoinsture",
                                  )));

                      /*setState(() {
                  _myData = _recuperarPostagens(0);
                });*/
                      // Respond to button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey, // Background color
                    ),
                    icon: Icon(Icons.search, size: 18),
                    label: Text("Buscar"),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: FutureBuilder<List<ModelMoisture>>(
                  initialData: const <ModelMoisture>[],
                  future: _myData,
                  builder: (context, snapshot)

                      /*Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child:
                new  FutureBuilder<List<Post>>(
                  future:  _myData,
                  builder:  (context, snapshot)*/
                      {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          print("lista: Erro ao carregar $snapshot");
                          if (grade.text != "0000") {
                            Fluttertoast.showToast(
                                msg: "Não há itens para a Grade consultada",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 6,
                                backgroundColor: Colors.black26,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        } else {
                          print("lista: carregou!! ");

                          return DataTable2(
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            headingTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            columnSpacing: 0,
                            horizontalMargin: 10,
                            minWidth: 1300,
                            dataRowHeight: 20,
                            dividerThickness: 3,
                            showCheckboxColumn: false,
                            dataRowColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xFFFFFFFF)),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 10)),
                            columns: const [
                              // DataColumn(label: Text('COD_GRADE')),
                              DataColumn2(
                                  label: Text('Date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.M),
                              DataColumn2(
                                  label: Text('Shift',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Case',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Time',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.M),
                              //   DataColumn(label: Text('Casefirst')),
                              //  DataColumn(label: Text('Caselast')),
                              DataColumn2(
                                  label: Text('% Brabender',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text(' % Oven',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Cooler R',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Cooler L',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Blending',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Bthresh',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Stem',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Tips',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Packed Temp',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              /* DataColumn(label: Text('Out_crop')),
                              DataColumn(label: Text('Des_grade')),
                              DataColumn(label: Text('Method')),
                              DataColumn(label: Text('Product')),
                              DataColumn(label: Text('Pm1')),
                              DataColumn(label: Text('Pm2')),
                              DataColumn(label: Text('Pm3')),
                              DataColumn(label: Text('Pm4')),
                              DataColumn(label: Text('Pm5')),
                              DataColumn(label: Text('Pm6')),
                              DataColumn(label: Text('Pm7')),
                              DataColumn(label: Text('Pm8')),
                              DataColumn(label: Text('Pm9')),
                              DataColumn(label: Text('Pm10')),
                              DataColumn(label: Text('Pm11')),
                              DataColumn(label: Text('Pm12')),*/
                            ],
                            rows: List.generate(
                              snapshot.data!.length,
                              (index) {
                                var emp = snapshot.data![index];
                                if (emp.sampledate.toString() != "null") {
                                  final DateTime now = DateTime.parse(emp.sampledate.toString());
                                  final DateFormat formatter = DateFormat(
                                      'dd-MM-yyyy'); //DateFormat('yyyy-MM-dd hh:mm');
                                  final String formatted =
                                  formatter.format(now);
                                  emp.sampledate = formatted;
                                } else if (emp.shift.toString() == "null") {
                                  emp.shift = 0;
                                } else if (emp.sampletime.toString() ==
                                    "null") {
                                  emp.sampletime = "0";
                                } else if (emp.brabender.toString() == "null") {
                                  emp.brabender = 0;
                                } else if (emp.oven.toString() == "null") {
                                  emp.oven = 0;
                                } else if (emp.coolerr.toString() == "null") {
                                  emp.coolerr = 0;
                                } else if (emp.coolerl.toString() == "null") {
                                  emp.coolerl = "0";
                                } else if (emp.blending.toString() == "null") {
                                  emp.blending = "0";
                                } else if (emp.bthresh.toString() == "null") {
                                  emp.bthresh = 0;
                                } else if (emp.stem.toString() == "null") {
                                  emp.stem = 0;
                                } else if (emp.tips.toString() == "null") {
                                  emp.tips = 0;
                                } else if (emp.ptemp.toString() == "null") {
                                  emp.ptemp = 0;
                                }
                                return DataRow(
                                    selected: selectedRow.contains(index) ||
                                            index == n && x % 2 == 0
                                        ? true
                                        : false,
                                    color: MaterialStateColor.resolveWith(
                                      (states) {
                                        if (selectedRow.contains(index) ||
                                            index == n && x % 2 == 0) {
                                          return Color(
                                                  Random().nextInt(0xffffffff))
                                              .withOpacity(0.5);
                                        } else {
                                          return Colors.white;
                                        }
                                      },
                                    ),
                                    onSelectChanged: (v) {
                                      setState(() {
                                        n = index;
                                        x = x + 1;
                                        onSelectedRow(v, index);
                                      });
                                    },
                                    cells: [
                                      /* DataCell(
                                Text(emp.cod_grade.toString()),
                              ),*/
                                      DataCell(
                                        Text(emp.sampledate.toString(),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(emp.shift.toString(),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(emp.box.toString(),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(emp.sampletime.toString(),
                                            textAlign: TextAlign.center),
                                      ),
                                      /*DataCell(
                                    Text(emp.casefirst.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.caselast.toString()),
                                  ),*/
                                      DataCell(
                                        Text(
                                            double.parse(
                                                    emp.brabender.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.oven.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.coolerr.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.coolerl.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(
                                                    emp.blending.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.bthresh.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.stem.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.tips.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ),
                                      DataCell(
                                        Text(
                                            double.parse(emp.ptemp.toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.center),
                                      ), /*DataCell(
                                    Text(emp.out_crop.toString()),
                                  ), DataCell(
                                    Text(emp.des_grade.toString()),
                                  ), DataCell(
                                    Text(emp.method.toString()),
                                  ),DataCell(
                                    Text(emp.product.toString()),
                                  ),DataCell(
                                    Text(emp.pm1.toString()),
                                  ),DataCell(
                                    Text(emp.pm2.toString()),
                                  ),DataCell(
                                    Text(emp.pm3.toString()),
                                  ),DataCell(
                                    Text(emp.pm4.toString()),
                                  ),DataCell(
                                    Text(emp.pm5.toString()),
                                  ),DataCell(
                                    Text(emp.pm6.toString()),
                                  ),DataCell(
                                    Text(emp.pm7.toString()),
                                  ),DataCell(
                                    Text(emp.pm8.toString()),
                                  ),DataCell(
                                    Text(emp.pm9.toString()),
                                  ),DataCell(
                                    Text(emp.pm10.toString()),
                                  ),DataCell(
                                    Text(emp.pm11.toString()),
                                  ),DataCell(
                                    Text(emp.pm12.toString()),
                                  ),*/
                                    ]);
                              },
                            ).toList(),
                          );

                          /* return ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){

                                List<Post> lista = snapshot.data ?? <Post>[];
                                Post post = lista[index];

                                return ListTile(

                                  title: new Center(child: new Text("COD_GRADE: " + post.cod_grade.toString(),)),
                                  subtitle: Text("BOX_INICIAL: " + post.box_inicial.toString() + "\t BOX_FINAL: " + post.box_final.toString() + "\t"
                                  + "BOX_TOTAL:" + post.box_total.toString() + "\t DATA_PROCESSO: " + post.data_processo.toString() + "\n"),

                                  // subtitle:  new Center(child: new Text("Carga: " + post.cod_carga.toString(),)),
                                 /* title: Text( "Empresa: " + post.cod_empresa.toString() ),
                                  subtitle: Text("Carga: " + post.cod_carga.toString() + "\n Teste: 001" + "\n teste" + "\n teste"),*/
                                );

                              }, separatorBuilder: (BuildContext context, int index) {

                                return Divider();
                          },
                          );*/

                        }
                        break;
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ]),
    ));
  }
}

/* FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder:  (context, snapshot){

          switch( snapshot.connectionState ){
            case ConnectionState.none :
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              if( snapshot.hasError ){
                print("lista: Erro ao carregar $snapshot");
              }else {

                print("lista: carregou!! ");
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){

                      List<Post> lista = snapshot.data ?? <Post>[];
                      Post post = lista[index];

                      return ListTile(
                        title: Text( "Empresa: " + post.cod_empresa.toString() ),
                        subtitle: Text("Carga: " + post.cod_carga.toString() ),
                      );

                    }
                );

              }
              break;
          }
      return Container();
        },
      ),
    );
  }
}*/

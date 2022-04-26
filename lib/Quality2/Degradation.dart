import 'dart:ui';
import 'package:atcsearch/Quality2/ModelsQuality/ModelDegradation.dart';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelMoisture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:atcsearch/Quality2/ConsultaCostumer.dart';

class Degradation extends StatefulWidget {
  String? valor, valor1, valor2;

  Degradation({this.valor, this.valor1, this.valor2});

  @override
  _DegradationState createState() => _DegradationState();
}

class _DegradationState extends State<Degradation> {
  late Future<List<ModelDegradation>> _myData = _recuperarPostagens();
  late TextEditingController safra;
  late TextEditingController grade;

  @override
  void initState() {
    super.initState();
    safra = TextEditingController();
    grade = TextEditingController();

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

  Future<List<ModelDegradation>> _recuperarPostagens() async {
    String url = "http://192.168.200.11/read.php?tipo=degradation&safra=" +
        safra.text +
        "&grade=" +
        grade.text;
    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    List<ModelDegradation> postagens = <ModelDegradation>[];
    for (var post in dadosJson) {
      // print("post: " + post["cod_carga"] );
      ModelDegradation p = ModelDegradation(
          post["sampledate"],
          post["sampletime"],
          post["shift"],
          post["box"],
          post["d1x1"],
          post["d12x12"],
          post["total12"],
          post["d14x14"],
          post["total14"],
          post["d18x18"],
          post["pan"],
          post["s332"],
          post["s7"],
          post["s12"],
          post["fiberspan"],
          post["totalstems"],
          post["ps4"]);
      postagens.add(p);
    }
    //print( postagens.toString() );

    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Degradation"),
        backgroundColor: Colors.black,
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 16, 0),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Codigo: " + grade.text + " Safra: " + safra.text,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ]),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                          ..color = Colors.black,
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

        Row(
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
                          interface: "Degradation",

                        )));

                /*setState(() {
                  _myData = _recuperarPostagens(0);
                });*/
                // Respond to button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Background color
              ),
              icon: Icon(Icons.search, size: 18),
              label: Text("Buscar"),
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            //https://stackoverflow.com/questions/55299332/make-datatable-scroll-bidirectional-in-flutter
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(children: [
                FutureBuilder<List<ModelDegradation>>(
                  initialData: const <ModelDegradation>[],
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
                        } else {
                          print("lista: carregou!! ");

                          return DataTable(
                            columns: const [
                              // DataColumn(label: Text('COD_GRADE')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Time')),
                              DataColumn(label: Text('Shift')),
                              DataColumn(label: Text('Case')),
                              DataColumn(label: Text('1x1')),
                              DataColumn(label: Text('1/2 x 1/2')),
                              DataColumn(label: Text('Total 1/2')),
                              DataColumn(label: Text('1/4 x 1/4')),
                              DataColumn(label: Text('Total 1/4')),
                              DataColumn(label: Text('1/8 x 1/8')),
                              DataColumn(label: Text('PAN')),
                              DataColumn(label: Text('3/32')),
                              DataColumn(label: Text('#7')),
                              DataColumn(label: Text('#12')),
                              DataColumn(label: Text('Pan (Fibers)')),
                              DataColumn(label: Text('Total Stem')),
                              DataColumn(label: Text('%>4')),
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

                                if(emp.ps4.toString() == "null"){
                                  emp.ps4 = "0";

                                }else if(emp.sampledate.toString() == "null"){
                                  emp.sampledate = "0";

                                }else if(emp.sampletime.toString() == "null"){
                                  emp.sampletime = "0";

                                }else if(emp.shift.toString() == "null"){
                                  emp.shift = 0;

                                }else if(emp.box.toString() == "null"){
                                  emp.box = 0;

                                }else if(emp.d1x1.toString() == "null"){
                                  emp.d1x1 = "0";

                                }else if(emp.d12x12.toString() == "null"){
                                  emp.d12x12 = "0";

                                }else if(emp.total12.toString() == "null"){
                                  emp.total12 = "0";

                                }else if(emp.d14x14.toString() == "null"){
                                  emp.d14x14 = "0";

                                }else if(emp.total14.toString() == "null"){
                                  emp.total14 = "0";

                                }else if(emp.pan.toString() == "null"){
                                  emp.pan = "0";

                                }else if(emp.s332.toString() == "null"){
                                  emp.s332 = "0";

                                }else if(emp.s7.toString() == "null"){
                                  emp.s7 = "0";

                                }else if(emp.s12.toString() == "null"){
                                  emp.s12 = "0";

                                }else if(emp.fiberspan.toString() == "null"){
                                  emp.fiberspan = "0";

                                }else if(emp.totalstems.toString() == "null"){
                                  emp.totalstems = "0";

                                }
                                return DataRow(cells: [
                                  /* DataCell(
                                Text(emp.cod_grade.toString()),
                              ),*/
                                  DataCell(
                                    Text(emp.sampledate.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.sampletime.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.shift.toString()),
                                  ),
                                   DataCell(
                                Text(emp.box.toString()),
                                  ),
                                  DataCell(
                                    Text(double.parse(emp.d1x1.toString()).toStringAsFixed(2)),
                                  ),
                                    DataCell(
                                      Text(double.parse(emp.d12x12.toString()).toStringAsFixed(2)),
                                  ),  DataCell(
                                    Text(double.parse(emp.total12.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.d14x14.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.total14.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.d18x18.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.pan.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.s332.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.s7.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.s12.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.fiberspan.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.totalstems.toString()).toStringAsFixed(2)),
                                  ),
                                  DataCell(
                                      Text(double.parse(emp.ps4.toString()).toStringAsFixed(2)),
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
              ]),
            ), //https://flutterhq.com/questions-and-answers/1284/how-to-create-rows-data-in-to-datatable-using-from-json-model-json-api-respons-flutter
          ),
        ),

        /**/
      ]),
    );
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

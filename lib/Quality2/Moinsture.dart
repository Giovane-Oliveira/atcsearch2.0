import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelMoisture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:atcsearch/Quality2/ConsultaCostumer.dart';

class Moinsture extends StatefulWidget {
  String? valor, valor1, valor2;

  Moinsture({this.valor, this.valor1, this.valor2});

  @override
  _MoinstureState createState() => _MoinstureState();
}

class _MoinstureState extends State<Moinsture> {
  late Future<List<ModelMoisture>> _myData = _recuperarPostagens(0);
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
      // print("post: " + post["cod_carga"] );
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Moinsture"),
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
                          interface: "Moinsture",

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
                FutureBuilder<List<ModelMoisture>>(
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
                        } else {
                          print("lista: carregou!! ");

                          return DataTable(
                            columns: const [
                              // DataColumn(label: Text('COD_GRADE')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Shift')),
                              DataColumn(label: Text('Case')),
                              DataColumn(label: Text('Time')),
                           //   DataColumn(label: Text('Casefirst')),
                            //  DataColumn(label: Text('Caselast')),
                              DataColumn(label: Text('% Brabender')),
                              DataColumn(label: Text('% Oven')),
                              DataColumn(label: Text('Cooler R')),
                              DataColumn(label: Text('Cooler L')),
                              DataColumn(label: Text('Blending')),
                              DataColumn(label: Text('Bthresh')),
                              DataColumn(label: Text('Stem')),
                              DataColumn(label: Text('Tips')),
                              DataColumn(label: Text('Packed Temp')),
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
                                if(emp.sampledate.toString() == "null"){
                                  emp.sampledate = "0";

                                }else if(emp.shift.toString() == "null"){
                                  emp.shift = 0;

                                }else if(emp.sampletime.toString() == "null"){
                                  emp.sampletime = "0";

                                }else if(emp.brabender.toString() == "null"){
                                  emp.brabender = 0;

                                }else if(emp.oven.toString() == "null"){
                                  emp.oven = 0;

                                }else if(emp.coolerr.toString() == "null"){
                                  emp.coolerr = 0;

                                }else if(emp.coolerl.toString() == "null"){
                                  emp.coolerl = "0";

                                }else if(emp.blending.toString() == "null"){
                                  emp.blending = "0";

                                }else if(emp.bthresh.toString() == "null"){
                                  emp.bthresh = 0;

                                }else if(emp.stem.toString() == "null"){
                                  emp.stem = 0;

                                }else if(emp.tips.toString() == "null"){
                                  emp.tips = 0;

                                }else if(emp.ptemp.toString() == "null"){
                                  emp.ptemp = 0;

                                }
                                return DataRow(cells: [
                                  /* DataCell(
                                Text(emp.cod_grade.toString()),
                              ),*/
                                  DataCell(
                                    Text(emp.sampledate.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.shift.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.box.toString()),
                                  ),
                                   DataCell(
                                Text(emp.sampletime.toString()),
                                  ),
                                  /*DataCell(
                                    Text(emp.casefirst.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.caselast.toString()),
                                  ),*/ DataCell(
                                    Text(double.parse(emp.brabender.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.oven.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.coolerr.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.coolerl.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.blending.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.bthresh.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.stem.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.tips.toString()).toStringAsFixed(2)),
                                  ), DataCell(
                                    Text(double.parse(emp.ptemp.toString()).toStringAsFixed(2)),
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

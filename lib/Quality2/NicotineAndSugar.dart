import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelCC.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:data_table_2/data_table_2.dart';

import 'package:atcsearch/Quality2/ConsultaCostumer.dart';

class NicotineAndSugar extends StatefulWidget {
  String? valor, valor1, valor2;

  NicotineAndSugar({this.valor, this.valor1, this.valor2});

  @override
  _NicotineAndSugarState createState() => _NicotineAndSugarState();
}

class _NicotineAndSugarState extends State<NicotineAndSugar> {
  late Future<List<Post>> _myData = _recuperarPostagens(0);
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

  Future<List<Post>> _recuperarPostagens(int n) async {
    String url = "http://192.168.200.11/read.php?tipo=consultar&safra=" +
        safra.text +
        "&grade=" +
        grade.text;
    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    List<Post> postagens = <Post>[];
    for (var post in dadosJson) {
      // print("post: " + post["cod_carga"] );
      Post p = Post(
          post["data_processo"],
          post["box_inicial"],
          post["box_final"],
          post["umidade"],
          post["peso_amostra"],
          post["leitura_nicotina"],
          post["leitura_acucar"],
          post["result_nicotina"],
          post["result_acucar"]);
      postagens.add(p);
    }
    //print( postagens.toString() );

    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nicotine and Sugar"),
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
                          interface: "NicotineAndSugar",

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
                FutureBuilder<List<Post>>(
                  initialData: const <Post>[],
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
                              DataColumn(label: Text('Case First')),
                              DataColumn(label: Text('Case Last')),
                              // DataColumn(label: Text('BOX_TOTAL')),
                              DataColumn(label: Text('Moisture')),
                              DataColumn(label: Text('Weight')),
                              DataColumn(label: Text('Read Nicotine mg/mL')),
                              DataColumn(label: Text('Read Sugar mg/mL')),
                              DataColumn(label: Text('Result_Nicotine %')),
                              DataColumn(label: Text('Result_Sugar %')),
                              /*  DataColumn(label: Text('DES_GRADE')),
                          DataColumn(label: Text('DES_PESSOA')),
                          DataColumn(label: Text('USER_INSERCAO')),
                          DataColumn(label: Text('DT_HR_INSERCAO')),
                          DataColumn(label: Text('USER_ALTERACAO')),
                          DataColumn(label: Text('DT_HR_INSERCAO')),
                          DataColumn(label: Text('NIC_TIPO_CALCULO')),*/
                            ],
                            rows: List.generate(
                              snapshot.data!.length,
                              (index) {
                                var emp = snapshot.data![index];
                                if(emp.data_processo.toString() == "null"){
                                  emp.data_processo = "0";

                                }else if(emp.box_inicial.toString() == "null"){
                                  emp.box_inicial = 0;

                                }else if(emp.box_final.toString() == "null"){
                                  emp.box_final = 0;

                                }else if(emp.umidade.toString() == "null"){
                                  emp.umidade = "0";

                                }else if(emp.peso_amostra.toString() == "null"){
                                  emp.peso_amostra = "0";

                                }else if(emp.leitura_nicotina.toString() == "null"){
                                  emp.leitura_nicotina = "0";

                                }else if(emp.leitura_acucar.toString() == "null"){
                                  emp.leitura_acucar = "0";

                                }else if(emp.result_nicotina.toString() == "null"){
                                  emp.result_nicotina = "0";

                                }else if(emp.result_acucar.toString() == "null"){
                                  emp.result_acucar = "0";

                                }

                                return DataRow(cells: [
                                  /* DataCell(
                                Text(emp.cod_grade.toString()),
                              ),*/
                                  DataCell(
                                    Text(emp.data_processo.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.box_inicial.toString()),
                                  ),
                                  DataCell(
                                    Text(emp.box_final.toString()),
                                  ),
                                  /* DataCell(
                                Text(emp.box_total.toString()),
                              ),*/

                                  DataCell(
                                    Text((double.parse(emp.umidade.toString()).toStringAsFixed(2)).toString()),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.peso_amostra.toString()).toStringAsFixed(3)).toString()),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_nicotina.toString()).toStringAsFixed(4)).toString()),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_acucar.toString()).toStringAsFixed(2)).toString()),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.result_nicotina.toString()).toStringAsFixed(2)).toString()),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.result_acucar.toString()).toStringAsFixed(2)).toString()),
                                  ),
                                  /*  DataCell(
                                Text(emp.des_grade.toString()),
                              ),
                              DataCell(
                                Text(emp.des_pessoa.toString()),
                              ),
                              DataCell(
                                Text(emp.user_insercao.toString()),
                              ),
                              DataCell(
                                Text(emp.dt_hr_insercao.toString()),
                              ),

                              DataCell(
                                Text(emp.dt_hr_insercao.toString()),
                              ),
                              DataCell(
                                Text(emp.user_alteracao.toString()),
                              ),
                              DataCell(
                                Text(emp.nic_tipo_calculo.toString()),
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

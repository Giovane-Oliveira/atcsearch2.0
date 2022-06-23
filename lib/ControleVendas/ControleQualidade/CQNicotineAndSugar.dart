import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelCC.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:data_table_2/data_table_2.dart';
import 'package:atcsearch/Quality2/ConsultaCostumer.dart';

import 'ControleQualidade.dart';

class CQNicotineAndSugar extends StatefulWidget {
  String? valor, valor1, valor2;

  CQNicotineAndSugar({this.valor, this.valor1, this.valor2});

  @override
  _CQNicotineAndSugarState createState() => _CQNicotineAndSugarState();
}

class _CQNicotineAndSugarState extends State<CQNicotineAndSugar> {
  late Future<List<Post>> _myData = _recuperarPostagens();
  late TextEditingController safra;
  late TextEditingController grade;
  late TextEditingController cliente;
  int n =
      -1; // 0 para deixar selecionada a prinmeira linha e -1 para nenhuma no datable
  int x = 0;
  bool checked = false;
  List<int> selectedRow = [];
  double mediaNicotine = 0;
  double mediaSugar = 0;
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
    cliente.text = "";

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

  bool setVisible() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return true; // is portrait
    } else {
      return false; // is landscape
    }
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

  Future<List<Post>> _recuperarPostagens() async {
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
      mediaNicotine = mediaNicotine + double.parse(post["result_nicotina"]);
      mediaSugar = mediaSugar + double.parse(post["result_acucar"]);
      count = count + 1;
      setState(() {
        cliente.text = post["des_pessoa"];
      });

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
    mediaNicotine = mediaNicotine / count;
    mediaSugar = mediaSugar / count;

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
        title: "Nicotine And Sugar",
        theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: AppBarTheme(
        //backgroundColor: Colors.black,
        //foregroundColor: Colors.white, //here you can give the text color
    )
    //accentColor: Colors.orange,

    ),
    home: Scaffold(
    appBar: AppBar(
    leading: BackButton(
    color: Colors.white,
    onPressed: () {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => ControleQualidade()));
    }),
    title: Text(
    "Nicotine And Sugar",
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
                                    interface: "CQNicotineAndSugar",
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
                    label: Text("Nova Consulta"),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: FutureBuilder<List<Post>>(
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
                            dividerThickness: 3,
                            dataRowColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xFFFFFFFF)),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 10)),
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            headingTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            columnSpacing: 0,
                            horizontalMargin: 10,
                            minWidth: 600,
                            dataRowHeight: 20,
                            showCheckboxColumn: false,
                            columns: const [
                              // DataColumn(label: Text('COD_GRADE')),
                              DataColumn2(
                                  label: Text('Date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Case First',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              DataColumn2(
                                  label: Text('Case Last',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              // DataColumn(label: Text('BOX_TOTAL')),
                              DataColumn2(
                                  label: Text('Moisture',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              // DataColumn2(label: Text('Weight', textAlign:TextAlign.center, style: TextStyle(fontSize: 13)), size: ColumnSize.S),
                              //DataColumn2(label: Text('Read Nicotine mg/mL', textAlign:TextAlign.center,style: TextStyle(fontSize: 13)), size: ColumnSize.M), //mg/mL
                              //DataColumn2(label: Text('Read Sugar mg/mL', textAlign:TextAlign.center,style: TextStyle(fontSize: 13)), size: ColumnSize.M), //mg/mL
                              DataColumn2(
                                  label: Text('Result Nicotine %',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.M),
                              //%
                              DataColumn2(
                                  label: Text('Result_Sugar %',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13)),
                                  size: ColumnSize.S),
                              //%
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
                                if (emp.data_processo.toString() != "null") {
                                  final DateTime now = DateTime.parse(emp.data_processo.toString());
                                  final DateFormat formatter = DateFormat(
                                      'dd-MM-yyyy'); //DateFormat('yyyy-MM-dd hh:mm');
                                  final String formatted =
                                  formatter.format(now);
                                  emp.data_processo = formatted;
                                } else if (emp.box_inicial.toString() ==
                                    "null") {
                                  emp.box_inicial = 0;
                                } else if (emp.box_final.toString() == "null") {
                                  emp.box_final = 0;
                                } else if (emp.umidade.toString() == "null") {
                                  emp.umidade = "0";
                                } else if (emp.peso_amostra.toString() ==
                                    "null") {
                                  emp.peso_amostra = "0";
                                } else if (emp.leitura_nicotina.toString() ==
                                    "null") {
                                  emp.leitura_nicotina = "0";
                                } else if (emp.leitura_acucar.toString() ==
                                    "null") {
                                  emp.leitura_acucar = "0";
                                } else if (emp.result_nicotina.toString() ==
                                    "null") {
                                  emp.result_nicotina = "0";
                                } else if (emp.result_acucar.toString() ==
                                    "null") {
                                  emp.result_acucar = "0";
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
                                        Text(
                                          (double.parse(emp.umidade.toString())
                                                  .toStringAsFixed(2))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*   DataCell(
                                    Text((double.parse(emp.peso_amostra.toString()).toStringAsFixed(3)).toString(), textAlign:TextAlign.center,),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_nicotina.toString()).toStringAsFixed(4)).toString(), textAlign:TextAlign.center,),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_acucar.toString()).toStringAsFixed(2)).toString(), textAlign:TextAlign.center,),
                                  ),*/
                                      DataCell(
                                        Text(
                                          (double.parse(emp.result_nicotina
                                                      .toString())
                                                  .toStringAsFixed(2))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          (double.parse(emp.result_acucar
                                                      .toString())
                                                  .toStringAsFixed(2))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
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
              ),
              //https://flutterhq.com/questions-and-answers/1284/how-to-create-rows-data-in-to-datatable-using-from-json-model-json-api-respons-flutter
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 5),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AVG Nicotine:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " " +
                                  (double.parse(mediaNicotine.toString())
                                          .toStringAsFixed(2))
                                      .toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\tAVG Sugar:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " " +
                                  (double.parse(mediaSugar.toString())
                                          .toStringAsFixed(2))
                                      .toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ]),
                    ),
                  ]),
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

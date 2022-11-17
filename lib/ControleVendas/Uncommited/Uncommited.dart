import 'dart:math';
import 'dart:ui';
import 'package:atcsearch/ControleVendas/ControleVendas.dart';
import 'package:atcsearch/ControleVendas/InfoCompany.dart';
import 'package:atcsearch/ControleVendas/Uncommited/ModelPrincipal.dart';
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
import 'package:multiselect/multiselect.dart';

class Uncomitted extends StatefulWidget {
  String? valor, valor1, valor2;

  Uncomitted({this.valor1, this.valor2});

  @override
  _UncomittedState createState() => _UncomittedState();
}

class _UncomittedState extends State<Uncomitted> {
  late Future<List<ModelPrincipal>> _myData = _recuperarPostagens();
  late TextEditingController dataFinal;
  late TextEditingController dataInicial;
  late TextEditingController empresa;
  List<String> selected = [];
  List<String> selectedvar = [];
  int n =
      -1; // 0 para deixar selecionada a prinmeira linha e -1 para nenhuma no datable
  int x = 0;
  bool checked = false;
  List<int> selectedRow = [];
  double totalvendas = 0;
  double totalcost = 0;
  double totalpack = 0;
  double totalexterno = 0;

  int count = 0;
  static int v = 0;

  @override
  void initState() {
    super.initState();
    dataFinal = TextEditingController();
    dataInicial = TextEditingController();
    empresa = TextEditingController();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    dataFinal.text = formatted.toString();
    dataInicial.text = formatted.toString();
    empresa.text = "";

    setState(() {
      if (widget.valor1 != null) {
        //    dataInicial.text = "${widget.valor}";
        //   dataFinal.text = "${widget.valor2}";
        empresa.text = "${widget.valor1} - ${widget.valor2}";
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

  Future<List<ModelPrincipal>> _recuperarPostagens() async {
    List<ModelPrincipal> postagens = <ModelPrincipal>[];

    String url = "";

    if (selected.length == 1) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url =
            "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
                dataInicial.text +
                "&anofinal=" +
                dataFinal.text +
                "&empresa=${widget.valor1.toString()}" +
                "&selected='${selected[0].toString()}'" +
                "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 2) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 3) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 4) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 5) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 6) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}', '${selected[5].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}', '${selected[5].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    } else if (selected.length == 7) {
      if (selectedvar.length == 2) {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}', '${selected[5].toString()}','${selected[6].toString()}'" +
            "&variedade='${selectedvar[0].toString()}', '${selectedvar[1].toString()}'";
      } else {
        url = "http://192.168.200.11/read.php?tipo=uncommitedprincipal&anoinicial=" +
            dataInicial.text +
            "&anofinal=" +
            dataFinal.text +
            "&empresa=${widget.valor1.toString()}" +
            "&selected='${selected[0].toString()}', '${selected[1].toString()}', '${selected[2].toString()}', '${selected[3].toString()}', '${selected[4].toString()}', '${selected[5].toString()}','${selected[6].toString()}'" +
            "&variedade='${selectedvar[0].toString()}'";
      }
    }

    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    totalcost = 0;
    totalpack = 0;
    totalvendas = 0;
    for (var post in dadosJson) {
      // print("post: " + post["cod_carga"] );

       count = count + 1;
      setState(() {


        totalpack = totalpack +  ((double.parse(post["KG_OUTPUT"]) - double.parse(post["VENDA"]) - double.parse(post["KG_SAIDA"])) / double.parse(post["PACOTE"]));
        totalcost = totalcost +  ((double.parse(post["KG_OUTPUT"]) - double.parse(post["VENDA"]) - double.parse(post["KG_SAIDA"])) * double.parse(post["COST_PRICE"]));
        totalvendas = totalvendas + double.parse(post["VENDA"]);
      });

      ModelPrincipal p = ModelPrincipal(
          post["SAFRA"],
          post["BLEND"],
          post["COD_BLEND"],
          post["DES_VARIEDADE"],
          post["DES_CATEGORIA"],
          post["DL_MARKET"],
          post["TOTAL_MARKET"],
          post["NET_KG"],
          post["COST_PRICE"],
          post["DT_FIM_JUROS"],
          post["KG_PEXTERNO"],
          post["KG_SAIDA"],
          post["KG_OUTPUT"],
          post["PACOTE"],
          post["VENDA"]);
      postagens.add(p);
    }

    print("count ${count}");

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
        title: "Uncommited",
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
                      context,
                      MaterialPageRoute(
                          builder: (context) => ControleVendas()));
                }),
            title: Text(
              "Uncommitted",
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 5, 0),
                            child: TextFormField(
                              /*   onChanged: (teste) {
                                setState(() {
                                  _myData = _recuperarPostagens();
                                });
                              },*/
                              controller: dataInicial,
                              obscureText: false,
                              //   keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefix: Text("Year: "),
                                isDense: true,
                                hintText: 'Year of Blend',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              //cursorColor: Colors.orange,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Text("to"),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 5, 0),
                            child: TextFormField(
                              /*  onChanged: (teste) {
                                setState(() {
                                  _myData = _recuperarPostagens();
                                });
                              },*/
                              controller: dataFinal,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefix: Text("Year: "),
                                isDense: true,
                                hintText: 'Insira o ano',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              //cursorColor: Colors.orange,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          //  child: GestureDetector(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: TextFormField(
                              //enabled: false,
                              readOnly: true,
                              //focusNode: FocusNode(),
                              //enableInteractiveSelection: false,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InfoCompany(),
                                  ),
                                );
                              },
                              /*   onChanged: (teste) {
                        setState(() {
                          _myData = _recuperarPostagens();
                        });
                      },*/
                              controller: empresa,
                              obscureText: false,
                              //   keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                //prefix: Text("Company: "),
                                isDense: true,
                                hintText: 'Inform the company',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              //cursorColor: Colors.orange,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          /*    onTap: () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InfoCompany(),
                      ),
                    );

                  },
                        ),*/

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
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: setVisible(),
                    child:   Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  selected = x;
                                  v = 0;
                                });
                              },
                              options: [
                                'LEAVES',
                                'BY PRODUCTS',
                                '3RD',
                                'SAMPLES',
                                'DESTALA MANUAL',
                                'TALO DESTALA MANUAL',
                                'QUEBRA PROCESSSO'
                              ],
                              selectedValues: selected,
                              whenEmpty: 'Category',
                            ),
                          ),
                        ),
                      ],
                    ),
                ),

                Visibility(
                  visible: setVisible(),
                  child:  Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(100, 10, 100, 0),
                        child: DropDownMultiSelect(
                          onChanged: (List<String> y) {
                            setState(() {
                              selectedvar = y;
                              v = 0;
                            });
                          },
                          options: ['VA', 'BY'],
                          selectedValues: selectedvar,
                          whenEmpty: 'Variety',
                        ),
                      ),
                    )
                  ],
                ),
                ),

                Visibility(
                  visible: setVisible(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              v = 1;
                              _myData = _recuperarPostagens();
                              /* totalpack = totalpack;
                            totalvendas = totalvendas;
                            totalcost = totalcost;*/
                            });

                            /* Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConsultaCostumer(
                                    interface: "CQNicotineAndSugar",
                                  )));*/

                            /*setState(() {
                  _myData = _recuperarPostagens(0);
                });*/
                            // Respond to button press
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey, // Background color
                          ),
                          icon: Icon(Icons.search, size: 18),
                          label: Text("Consultar"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: FutureBuilder<List<ModelPrincipal>>(
                      initialData: const <ModelPrincipal>[],
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
                              if (!empresa.text.isEmpty &&
                                  selected.length > 0 &&
                                  selectedvar.length > 0 &&
                                  v != 0) {
                                Fluttertoast.showToast(
                                    msg: "Não há informações",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 6,
                                    backgroundColor: Colors.black26,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              } else if (empresa.text == "" &&
                                      selected.length == 0 &&
                                      selectedvar.length == 0 &&
                                      dataFinal.text.isEmpty &&
                                      dataInicial.text.isEmpty ||
                                  v != 0) {
                                v = 0;
                                Fluttertoast.showToast(
                                    msg: "Preencha as informações",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
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
                                    border: Border.all(
                                        color: Colors.black, width: 10)),
                                headingRowHeight: 30,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.black),
                                headingTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                columnSpacing: 0,
                                horizontalMargin: 10,
                                minWidth: 1000,
                                dataRowHeight: 20,
                                showCheckboxColumn: false,
                                columns: const [
                                  // DataColumn(label: Text('COD_GRADE')),
                                  /* DataColumn2(
                                      label: Text('SAFRA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),*/
                                  DataColumn2(
                                      label: Text('BLEND',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.L),
                                  /*   DataColumn2(
                                      label: Text('COD_BLEND',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),*/
                                  // DataColumn(label: Text('BOX_TOTAL')),
                                /*  DataColumn2(
                                      label: Text('DES_VARIEDADE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),*/
                                  // DataColumn2(label: Text('Weight', textAlign:TextAlign.center, style: TextStyle(fontSize: 13)), size: ColumnSize.S),
                                  //DataColumn2(label: Text('Read Nicotine mg/mL', textAlign:TextAlign.center,style: TextStyle(fontSize: 13)), size: ColumnSize.M), //mg/mL
                                  //DataColumn2(label: Text('Read Sugar mg/mL', textAlign:TextAlign.center,style: TextStyle(fontSize: 13)), size: ColumnSize.M), //mg/mL
                               /*   DataColumn2(
                                      label: Text('DES_CATEGORIA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.L),*/
                                  //%
                                  /* DataColumn2(
                                      label: Text('DL_MARKET',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),*/

                                  DataColumn2(
                                      label: Text('COST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),

                                  DataColumn2(
                                      label: Text('TOTAL COST',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.M),




                                  DataColumn2(
                                      label: Text('KG P. EXTERNO',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),

                                  DataColumn2(
                                      label: Text('TOTAL_MARKET',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),




                                  /*DataColumn2(
                                      label: Text('DT_FIM_JUROS',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),*/

                                  /*  DataColumn2(
                                      label: Text('KG_SAIDA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.M),
                                  DataColumn2(
                                      label: Text('KG_OUTPUT',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.M),*/
                                  DataColumn2(
                                      label: Text('# OF PACK',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),

                                  DataColumn2(
                                      label: Text('NET KGS',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.S),

                                 /* DataColumn2(
                                      label: Text('T. MARKET',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.M),*/



                                  /* DataColumn2(
                                      label: Text('VENDA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13)),
                                      size: ColumnSize.M),*/

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
                                    if (emp.SAFRA == 0) {
                                      /*final DateTime now = DateTime.parse(emp.data_processo.toString());
                                      final DateFormat formatter = DateFormat(
                                          'dd-MM-yyyy'); //DateFormat('yyyy-MM-dd hh:mm');
                                      final String formatted =
                                      formatter.format(now);
                                      emp.data_processo = formatted;*/
                                      emp.SAFRA = 0;
                                    } else if (emp.BLEND.toString() == "null") {
                                      emp.BLEND = "0";
                                    } else if (emp.COD_BLEND == 0) {
                                      emp.COD_BLEND = 0;
                                    } else if (emp.DES_VARIEDADE.toString() ==
                                        "null") {
                                      emp.DES_VARIEDADE = "0";
                                    } else if (emp.DES_CATEGORIA.toString() ==
                                        "null") {
                                      emp.DES_CATEGORIA = "null";
                                    } else if (emp.DL_MARKET.toString() ==
                                        "null") {
                                      emp.DL_MARKET = "0";
                                    } else if (emp.TOTAL_MARKED.toString() ==
                                        "null") {
                                      emp.TOTAL_MARKED = "0";
                                    } else if (emp.NET_KG.toString() ==
                                        "null") {
                                      emp.NET_KG = "0";
                                    } else if (emp.COST_PRICE.toString() ==
                                        "null") {
                                      emp.COST_PRICE = "0";
                                    } else if (emp.DT_FIM_JUROS.toString() ==
                                        "null") {
                                      emp.DT_FIM_JUROS = "0";
                                    } else if (emp.KG_PEXTERNO.toString() ==
                                        "null") {
                                      emp.KG_PEXTERNO = "0";
                                    } else if (emp.KG_PEXTERNO.toString() ==
                                        "null") {
                                      emp.KG_PEXTERNO = "0";
                                    } else if (emp.KG_SAIDA.toString() ==
                                        "null") {
                                      emp.KG_SAIDA = "0";
                                    } else if (emp.KG_OUTPUT.toString() ==
                                        "null") {
                                      emp.KG_OUTPUT = "0";
                                    } else if (emp.PACOTE.toString() ==
                                        "null") {
                                      emp.PACOTE = "0";
                                    } else if (emp.VENDA.toString() == "null") {
                                      emp.VENDA = "0";
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
                                              return Color(Random()
                                                      .nextInt(0xffffffff))
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
                                          /*     DataCell(
                                            Text(emp.SAFRA.toString()),
                                          ),*/
                                          DataCell(
                                            Text(emp.BLEND.toString()),
                                          ),
                                          /*   DataCell(
                                            Text(emp.COD_BLEND.toString()),
                                          ),*/

                                  /*        DataCell(
                                            Text(
                                              emp.DES_VARIEDADE.toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),*/
                                          /*   DataCell(
                                    Text((double.parse(emp.peso_amostra.toString()).toStringAsFixed(3)).toString(), textAlign:TextAlign.center,),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_nicotina.toString()).toStringAsFixed(4)).toString(), textAlign:TextAlign.center,),
                                  ),
                                  DataCell(
                                    Text((double.parse(emp.leitura_acucar.toString()).toStringAsFixed(2)).toString(), textAlign:TextAlign.center,),
                                  ),*/
                                  /*        DataCell(
                                            Text(
                                              emp.DES_CATEGORIA.toString(),
                                              /* (double.parse(emp.DES_CATEGORIA
                                                  .toString())
                                                  .toStringAsFixed(2))
                                                  .toString(),*/
                                              textAlign: TextAlign.center,
                                            ),
                                          ),*/
                                          /*  DataCell(
                                            Text(
                                            //  emp.DL_MARKET.toString(),
                                              (double.parse(emp.DL_MARKET
                                                  .toString())
                                                  .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),*/
                                       /*   DataCell(
                                            Text(
                                              (double.parse(emp.TOTAL_MARKED
                                                          .toString())
                                                      .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),*/

                                          DataCell(
                                            Text(
                                              (double.parse(emp.COST_PRICE
                                                  .toString())
                                                  .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          DataCell(
                                            Text(
                                              ((double.parse(emp.KG_OUTPUT.toString()) - double.parse(emp.VENDA.toString()) - double.parse(emp.KG_SAIDA.toString())) * double.parse(emp.COST_PRICE.toString())).toStringAsFixed(2)
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),



                                          /*  DataCell(
                                Text(emp.DT_FIM_JUROS.toString()),
                              ),*/

                                          DataCell(
                                            Text(
                                              (double.parse(emp.KG_PEXTERNO
                                                          .toString())
                                                      .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          DataCell(
                                            Text(
                                              ((double.parse(emp.KG_OUTPUT.toString()) - double.parse(emp.VENDA.toString()) - double.parse(emp.KG_SAIDA.toString())) * double.parse(emp.DL_MARKET.toString())).toStringAsFixed(2)
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),


                                          DataCell(
                                            Text(
                                              ((double.parse(emp.KG_OUTPUT.toString()) - double.parse(emp.VENDA.toString()) - double.parse(emp.KG_SAIDA.toString())) / double.parse(emp.PACOTE.toString())).toStringAsFixed(2)
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          DataCell(
                                            Text(
                                              (double.parse(
                                                  emp.NET_KG.toString())
                                                  .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          /*  DataCell(
                                Text(
                                  (double.parse(emp.KG_SAIDA
                                      .toString())
                                      .toStringAsFixed(2))
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  (double.parse(emp.KG_OUTPUT
                                      .toString())
                                      .toStringAsFixed(2))
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ), */


                                          /*DataCell(
                                            Text(
                                              (double.parse(emp.VENDA
                                                  .toString())
                                                  .toStringAsFixed(2))
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "T. VENDA:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " " +
                                      (double.parse(totalvendas.toString())
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
                                  "\tT. COST:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " " +
                                      (double.parse(totalcost.toString())
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
                                  "\tT. PACK:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " " +
                                      (double.parse(totalpack.toString())
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

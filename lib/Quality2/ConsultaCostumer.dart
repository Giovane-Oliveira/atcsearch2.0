import 'dart:ui';
import 'package:atcsearch/Quality2/Degradation.dart';
import 'package:atcsearch/Quality2/Moinsture.dart';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelNS.dart';
import 'package:atcsearch/Quality2/NicotineAndSugar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConsultaCostumer extends StatefulWidget {
  String? interface;

  ConsultaCostumer({this.interface});

  @override
  _ConsultaCostumerState createState() => _ConsultaCostumerState();
}

class _ConsultaCostumerState extends State<ConsultaCostumer> {
  late Future<List<Grade>> _myData = _recuperarPostagens();
  late TextEditingController safra;
  late TextEditingController grade;

  @override
  void initState() {
    super.initState();
    grade = TextEditingController();
    safra = TextEditingController();
    grade.addListener(() {
      _recuperarPostagens();
    });

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    safra.text = formatted.toString();
    grade.text = "";
  }

  Future<List<Grade>> _recuperarPostagens() async {
    String url = "http://192.168.200.11/read.php?tipo=grade";

    if (!grade.text.isEmpty && !safra.text.isEmpty) {
      url = "http://192.168.200.11/read.php?tipo=grade&grade=" +
          grade.text +
          "&safra=" +
          safra.text;
    } else if (!grade.text.isEmpty) {
      url = "http://192.168.200.11/read.php?tipo=grade&grade=" + grade.text;
    } else if (!safra.text.isEmpty) {
      url = "http://192.168.200.11/read.php?tipo=safra&safra=" + safra.text;
    }

    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    List<Grade> postagens = <Grade>[];
    for (var post in dadosJson) {
      // print("post: " + post["cod_carga"] );
      Grade p = Grade(post["crop"], post["cod_grade"], post["des_grade"],
          post["cod_cliente"], post["sample"]);
      postagens.add(p);
    }
    //print( postagens.toString() );

    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Grade"),
        backgroundColor: Colors.black,
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
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
                    onChanged: (teste) {
                      setState(() {
                        _myData = _recuperarPostagens();
                      });
                    },
                    controller: grade,
                    obscureText: false,
                    //   keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text("Grade: "),
                      isDense: true,
                      hintText: 'Grade',
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
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(2, 0, 5, 0),
                  child: TextFormField(
                    controller: safra,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text("Safra:"),
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
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
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
                setState(() {
                  _myData = _recuperarPostagens();
                });
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: FutureBuilder<List<Grade>>(
              future: _myData,
              builder: (context, snapshot) {
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
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Grade> lista = snapshot.data ?? <Grade>[];
                          Grade post = lista[index];

                          return ListTile(
                            onTap: () {
                              if(widget.interface.toString() == "NicotineAndSugar"){

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NicotineAndSugar(
                                          valor: post.cod_grade.toString(),
                                          valor1: post.des_grade,
                                          valor2: post.crop.toString(),
                                        )));
                              }else if(widget.interface.toString() == "Moinsture"){

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Moinsture(
                                          valor: post.cod_grade.toString(),
                                          valor1: post.des_grade,
                                          valor2: post.crop.toString(),
                                        )));

                              }else if(widget.interface.toString() == "Degradation"){

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Degradation(
                                          valor: post.cod_grade.toString(),
                                          valor1: post.des_grade,
                                          valor2: post.crop.toString(),
                                        )));

                              }


                            },
                            title: new Center(
                                child: new Text(
                              "COD.GRADE: " + post.cod_grade.toString(),
                            )),
                            subtitle: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("GRADE: " + post.des_grade,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "SAFRA: " +
                                          post.crop.toString() +
                                          "\n COD.CLIENTE: " +
                                          post.cod_cliente.toString() +
                                          "\n SAMPLE: " +
                                          post.sample,
                                      textAlign: TextAlign.center)
                                ]),

                            /*new Text(
                                    "GRADE: " +
                                        post.des_grade +
                                        "\n SAFRA: " +
                                        post.crop.toString() +
                                        "\n COD.CLIENTE: " +
                                        post.cod_cliente.toString() +
                                        "\n SAMPLE: " +
                                        post.sample,
                                    textAlign: TextAlign.center))*/
                            /* title: Text( "Empresa: " + post.cod_empresa.toString() ),
                                  subtitle: Text("Carga: " + post.cod_carga.toString() + "\n Teste: 001" + "\n teste" + "\n teste"),*/
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
                    }
                    break;
                }
                return Container();
              },
            ),
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

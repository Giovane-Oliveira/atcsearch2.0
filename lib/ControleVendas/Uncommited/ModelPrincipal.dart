class ModelPrincipal{

  int _SAFRA;
  String? _BLEND;
  int _COD_BLEND;
  String? _DES_VARIEDADE;
  String? _DES_CATEGORIA;

  int get SAFRA => _SAFRA;

  set SAFRA(int value) {
    _SAFRA = value;
  }

  String? _DL_MARKET;
  String? _TOTAL_MARKED;
  String? _NET_KG;
  String? _COST_PRICE;
  String? _DT_FIM_JUROS;
  String? _KG_PEXTERNO;
  String? _KG_SAIDA;
  String? _KG_OUTPUT;
  String? _PACOTE;
  String? _VENDA;

  String? get BLEND => _BLEND;

  ModelPrincipal(
      this._SAFRA,
      this._BLEND,
      this._COD_BLEND,
      this._DES_VARIEDADE,
      this._DES_CATEGORIA,
      this._DL_MARKET,
      this._TOTAL_MARKED,
      this._NET_KG,
      this._COST_PRICE,
      this._DT_FIM_JUROS,
      this._KG_PEXTERNO,
      this._KG_SAIDA,
      this._KG_OUTPUT,
      this._PACOTE,
      this._VENDA);

  set BLEND(String? value) {
    _BLEND = value;
  }

 int get COD_BLEND => _COD_BLEND;

  set COD_BLEND(int value) {
    _COD_BLEND = value;
  }

  String? get DES_VARIEDADE => _DES_VARIEDADE;

  set DES_VARIEDADE(String? value) {
    _DES_VARIEDADE = value;
  }

  String? get DES_CATEGORIA => _DES_CATEGORIA;

  set DES_CATEGORIA(String? value) {
    _DES_CATEGORIA = value;
  }

  String? get DL_MARKET => _DL_MARKET;

  set DL_MARKET(String? value) {
    _DL_MARKET = value;
  }

  String? get TOTAL_MARKED => _TOTAL_MARKED;

  set TOTAL_MARKED(String? value) {
    _TOTAL_MARKED = value;
  }

  String? get NET_KG => _NET_KG;

  set NET_KG(String? value) {
    _NET_KG = value;
  }

  String? get COST_PRICE => _COST_PRICE;

  set COST_PRICE(String? value) {
    _COST_PRICE = value;
  }

  String? get DT_FIM_JUROS => _DT_FIM_JUROS;

  set DT_FIM_JUROS(String? value) {
    _DT_FIM_JUROS = value;
  }

  String? get KG_PEXTERNO => _KG_PEXTERNO;

  set KG_PEXTERNO(String? value) {
    _KG_PEXTERNO = value;
  }

  String? get KG_SAIDA => _KG_SAIDA;

  set KG_SAIDA(String? value) {
    _KG_SAIDA = value;
  }

  String? get KG_OUTPUT => _KG_OUTPUT;

  set KG_OUTPUT(String? value) {
    _KG_OUTPUT = value;
  }

  String? get PACOTE => _PACOTE;

  set PACOTE(String? value) {
    _PACOTE = value;
  }

  String? get VENDA => _VENDA;

  set VENDA(String? value) {
    _VENDA = value;
  }
}
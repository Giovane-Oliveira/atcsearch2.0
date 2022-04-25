class Post {
  Post(
    this._data_processo,
    this._box_inicial,
    this._box_final,
    this._umidade,
    this._peso_amostra,
    this._leitura_nicotina,
    this._leitura_acucar,
    this._result_nicotina,
    this._result_acucar,
  );

  String? _data_processo;
  int _box_inicial;
  int _box_final;
  String? _umidade;
  String? _peso_amostra;
  String? _leitura_nicotina;
  String? _leitura_acucar;
  String? _result_nicotina;
  String? _result_acucar;

  int get box_inicial => _box_inicial;

  set box_inicial(int value) {
    _box_inicial = value;
  }

  int get box_final => _box_final;

  set box_final(int value) {
    _box_final = value;
  }

  String? get data_processo => _data_processo;

  set data_processo(String? value) {
    _data_processo = value;
  }

  String? get umidade => _umidade;

  set umidade(String? value) {
    _umidade = value;
  }

  String? get peso_amostra => _peso_amostra;

  set peso_amostra(String? value) {
    _peso_amostra = value;
  }

  String? get leitura_nicotina => _leitura_nicotina;

  set leitura_nicotina(String? value) {
    _leitura_nicotina = value;
  }

  String? get leitura_acucar => _leitura_acucar;

  set leitura_acucar(String? value) {
    _leitura_acucar = value;
  }

  String? get result_nicotina => _result_nicotina;

  set result_nicotina(String? value) {
    _result_nicotina = value;
  }

  String? get result_acucar => _result_acucar;

  set result_acucar(String? value) {
    _result_acucar = value;
  }
}

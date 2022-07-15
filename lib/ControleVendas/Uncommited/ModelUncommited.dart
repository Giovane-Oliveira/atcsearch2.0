class ModelUncommited{

int _COD_PESSOA;


ModelUncommited(this._COD_PESSOA, this._DES_PESSOA);

  int get COD_PESSOA => _COD_PESSOA;

  set COD_PESSOA(int value) {
    _COD_PESSOA = value;
  }

  String? _DES_PESSOA;

String? get DES_PESSOA => _DES_PESSOA;

  set DES_PESSOA(String? value) {
    _DES_PESSOA = value;
  }


}
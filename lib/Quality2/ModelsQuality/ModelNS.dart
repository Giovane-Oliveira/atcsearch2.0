class Grade {
  int _cod_grade;

  int get cod_grade => _cod_grade;

  set cod_grade(int value) {
    _cod_grade = value;
  }

  String _des_grade;
  int _cod_cliente;
  String _sample;
  int _crop;

  int get crop => _crop;

  set crop(int value) {
    _crop = value;
  }

  String get des_grade => _des_grade;

  set des_grade(String value) {
    _des_grade = value;
  }

  int get cod_cliente => _cod_cliente;

  set cod_cliente(int value) {
    _cod_cliente = value;
  }

  String get sample => _sample;

  set sample(String value) {
    _sample = value;
  }

  Grade(this._crop, this._cod_grade, this._des_grade, this._cod_cliente,
      this._sample);
}

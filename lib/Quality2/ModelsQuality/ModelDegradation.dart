class ModelDegradation{


String? _sampledate;
String? _sampletime;
int? _shift;
int? _box;

ModelDegradation(
      this._sampledate,
      this._sampletime,
      this._shift,
      this._box,
      this._d1x1,
      this._d12x12,
      this._total12,
      this._d14x14,
      this._total14,
      this._d18x18,
      this._pan,
      this._s332,
      this._s7,
      this._s12,
      this._fiberspan,
      this._totalstems,
      this._ps4);

String? _d1x1;
String? _d12x12;
String? _total12;
String? _d14x14;
String? _total14;
String? _d18x18;
String? _pan;
String? _s332;
String? _s7;
String? _s12;
String? _fiberspan;
String? _totalstems;
String? _ps4;

String? get sampledate => _sampledate;

  set sampledate(String? value) {
    _sampledate = value;
  }


String? get total14 => _total14;

set total14(String? value) {
  _total14 = value;
}

String? get sampletime => _sampletime;

  set sampletime(String? value) {
    _sampletime = value;
  }

int? get shift => _shift;

  set shift(int? value) {
    _shift = value;
  }

int? get box => _box;

  set box(int? value) {
    _box = value;
  }

String? get d1x1 => _d1x1;

  set d1x1(String? value) {
    _d1x1 = value;
  }

String? get d12x12 => _d12x12;

  set d12x12(String? value) {
    _d12x12 = value;
  }

String? get total12 => _total12;

  set total12(String? value) {
    _total12 = value;
  }

String? get d14x14 => _d14x14;

  set d14x14(String? value) {
    _d14x14 = value;
  }

String? get d18x18 => _d18x18;

  set d18x18(String? value) {
    _d18x18 = value;
  }

String? get pan => _pan;

  set pan(String? value) {
    _pan = value;
  }

String? get s332 => _s332;

  set s332(String? value) {
    _s332 = value;
  }

String? get s7 => _s7;

  set s7(String? value) {
    _s7 = value;
  }

String? get s12 => _s12;

  set s12(String? value) {
    _s12 = value;
  }

String? get fiberspan => _fiberspan;

  set fiberspan(String? value) {
    _fiberspan = value;
  }

String? get totalstems => _totalstems;

  set totalstems(String? value) {
    _totalstems = value;
  }

String? get ps4 => _ps4;

  set ps4(String? value) {
    _ps4 = value;
  }
}
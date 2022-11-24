import 'package:flutter/cupertino.dart';

class SeriesProvider extends ChangeNotifier {
  bool _isTap = false;
  String _imgPath = '';
  String _extension = '';
  String _name = '';
  String? _rating = '';
  int _start = 0;
  int _end = 0;

  bool get isTap => _isTap;
  String get imgPath => _imgPath;
  String get extension => _extension;
  String get name => _name;
  String? get rating => _rating;
  int get start => _start;
  int get end => _end;

  set isTap(bool value) {
    _isTap = value;
    notifyListeners();
  }

  set imgPath(String value) {
    _imgPath = value;
    notifyListeners();
  }

  set extension(String value) {
    _extension = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set rating(String? value) {
    _rating = value;
    notifyListeners();
  }

  set start(int value) {
    _start = value;
    notifyListeners();
  }

  set end(int value) {
    _end = value;
    notifyListeners();
  }
}

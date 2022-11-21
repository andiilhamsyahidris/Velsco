import 'package:flutter/cupertino.dart';

class CharactersProvider extends ChangeNotifier {
  bool _isTap = false;
  String _imgPath = '';
  String _extension = '';
  String _name = '';
  String? _description = '';

  bool get isTap => _isTap;
  String get imgPath => _imgPath;
  String get extension => _extension;
  String get name => _name;
  String? get description => _description;

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

  set desc(String value) {
    _description = value;
    notifyListeners();
  }
}

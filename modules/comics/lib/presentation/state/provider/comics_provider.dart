import 'package:flutter/cupertino.dart';

class ComicsProvider extends ChangeNotifier {
  bool _isTap = false;
  String _imgPath = '';
  String _extension = '';
  String _title = '';
  String? _description = '';
  String _page = '';

  String get imgPath => _imgPath;
  String get extension => _extension;
  String get title => _title;
  String? get description => _description;
  String get page => _page;
  bool get isTap => _isTap;

  set imgPath(String value) {
    _imgPath = value;
    notifyListeners();
  }

  set extension(String value) {
    _extension = value;
    notifyListeners();
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  set description(String? value) {
    _description = value;
    notifyListeners();
  }

  set page(String value) {
    _page = value;
    notifyListeners();
  }

  set isTap(bool value) {
    _isTap = value;
    notifyListeners();
  }
}

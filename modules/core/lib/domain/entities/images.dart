import 'package:equatable/equatable.dart';

class Images extends Equatable {
  String path;
  String extension;

  Images({
    required this.path,
    required this.extension,
  });

  @override
  List<Object> get props => [path, extension];
}

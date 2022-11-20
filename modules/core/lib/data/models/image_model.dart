import 'package:core/domain/entities/images.dart';
import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String path;
  final String extension;

  const ImageModel({
    required this.path,
    required this.extension,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        path: json['path'],
        extension: json['extension'],
      );
  Map<String, dynamic> toJson() => {
        'path': path,
        'extension': extension,
      };
  Images toEntity() {
    return Images(
      path: path,
      extension: extension,
    );
  }

  @override
  List<Object> get props => [path, extension];
}

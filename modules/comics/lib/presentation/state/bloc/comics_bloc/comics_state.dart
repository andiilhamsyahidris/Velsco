part of 'comics_bloc.dart';

abstract class ComicsState extends Equatable {
  const ComicsState();

  @override
  List<Object> get props => [];
}

class ComicsEmpty extends ComicsState {}

class ComicsLoading extends ComicsState {}

class ComicsError extends ComicsState {
  final String message;

  const ComicsError(this.message);

  @override
  List<Object> get props => [message];
}

class ComicsHasData extends ComicsState {
  final List<Comics> getComics;

  const ComicsHasData(this.getComics);

  @override
  List<Object> get props => [getComics];
}

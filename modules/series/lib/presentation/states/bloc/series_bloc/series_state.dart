part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();

  @override
  List<Object> get props => [];
}

class SeriesEmpty extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesError extends SeriesState {
  final String message;

  const SeriesError(this.message);
}

class SeriesHasData extends SeriesState {
  final List<Series> getSeries;

  const SeriesHasData(this.getSeries);

  @override
  List<Object> get props => [getSeries];
}

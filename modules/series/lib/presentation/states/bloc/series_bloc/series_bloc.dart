import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/series.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeries getSeries;
  SeriesBloc({required this.getSeries}) : super(SeriesEmpty()) {
    on<FetchSeriesList>((event, emit) async {
      emit(SeriesLoading());

      final seriesResult = await getSeries.execute();
      seriesResult.fold(
        (failure) => emit(SeriesError(failure.message)),
        (data) => emit(SeriesHasData(data)),
      );
    });
  }
}

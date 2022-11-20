import 'package:bloc/bloc.dart';
import 'package:comics/comics.dart';
import 'package:equatable/equatable.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final GetComics getComics;
  ComicsBloc({required this.getComics}) : super(ComicsEmpty()) {
    on<FetchComicsList>((event, emit) async {
      emit(ComicsLoading());

      final comicsResult = await getComics.execute();
      comicsResult.fold(
        (failure) => emit(ComicsError(failure.message)),
        (data) => emit(ComicsHasData(data)),
      );
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:character/character.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;
  CharactersBloc({required this.getCharacters}) : super(CharactersEmpty()) {
    on<FetchCharacterList>((event, emit) async {
      emit(CharactersLoading());

      final charactersResult = await getCharacters.execute();
      charactersResult.fold(
        (failure) => emit(CharactersError(failure.message)),
        (data) => emit(CharactersHasData(data)),
      );
    });
  }
}

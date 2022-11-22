import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:events/domain/entities/events.dart';
import 'package:events/domain/usecases/get_events.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEvents getEvents;
  EventsBloc({required this.getEvents}) : super(EventsEmpty()) {
    on<FetchEventsList>((event, emit) async {
      emit(EventsLoading());

      final eventsResult = await getEvents.execute();
      eventsResult.fold(
        (failure) => emit(EventsError(failure.message)),
        (data) => emit(EventsHasData(data)),
      );
    });
  }
}

part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsEmpty extends EventsState {}

class EventsLoading extends EventsState {}

class EventsError extends EventsState {
  final String message;

  const EventsError(this.message);
}

class EventsHasData extends EventsState {
  final List<Events> getEvents;

  const EventsHasData(this.getEvents);

  @override
  List<Object> get props => [getEvents];
}

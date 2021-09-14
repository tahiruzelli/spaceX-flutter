part of 'fetch_bloc.dart';

@immutable
abstract class FetchEvent {}

class FetchDataEvent extends FetchEvent {
  var query = "";
  FetchDataEvent({this.query});
}

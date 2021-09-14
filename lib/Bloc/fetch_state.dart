part of 'fetch_bloc.dart';

@immutable
abstract class FetchState {}

class FetchInitial extends FetchState {}

class FetchLoadedState extends FetchState {
  var fetchDatas;
  FetchLoadedState({this.fetchDatas});
}

class FetchLoadingState extends FetchState {
  FetchLoadingState();
}

class FetchErrorState extends FetchState {
  FetchErrorState();
}

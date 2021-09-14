import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spacex/services/fetch.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial());

  @override
  Stream<FetchState> mapEventToState(
    FetchEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield FetchLoadingState();
      var tmp = await FetchData().getLastFly();
      yield FetchLoadedState(fetchDatas: tmp);
    }
  }
}

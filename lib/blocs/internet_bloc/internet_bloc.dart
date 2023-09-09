import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_example/blocs/internet_bloc/internet_event.dart';
import 'package:rest_api_example/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InterentState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc(InterentState initialState) : super(InternetLoadingState()) {
    on<InternetDisconnectedEvent>(
        (event, emit) => emit(InternetDisconnectedState()));
    on<InternetConnectedEvent>((event, emit) => emit(InternetConnectedState()));

    connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          add(InternetConnectedEvent());
        } else {
          add(InternetDisconnectedEvent());
        }
      },
    );
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}

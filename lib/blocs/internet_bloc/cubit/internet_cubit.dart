// ignore: constant_identifier_names
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InterentState { Initial, Loading, Connected, Disconnected }

//cubit making

class InternetCubit extends Cubit<InterentState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InterentState.Initial) {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          emit(InterentState.Connected);
        } else {
          emit(InterentState.Disconnected);
        }
      },
    );
    @override
    close() {
      connectivitySubscription?.cancel();
      return super.close();
    }
  }
}

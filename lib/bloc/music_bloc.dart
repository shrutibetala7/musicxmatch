import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicxmatch/bloc/music_events.dart';
import 'package:musicxmatch/bloc/music_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription?.cancel();
    return super.close();
  }
}

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicSearchingState()) {
    on<MusicSearchedEvent>((event, emit) => emit(MusicSearchedState()));
    on<MusicSearchingEvent>((event, emit) => emit(MusicSearchingState()));
    on<MusicDetailsEvent>((event, emit) => emit(MusicDetailsState()));
    on<MusicNotSearchedEvent>((event, emit) => emit(MusicSearchingState()));
  }
}

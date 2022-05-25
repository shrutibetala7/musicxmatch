abstract class InternetState {}

class InitialState extends InternetState {}

class InternetGainedState extends InternetState {}

class InternetLostState extends InternetState {}

abstract class MusicState {}

class MusicSearchedState extends MusicState {}

class MusicSearchingState extends MusicState {}

class MusicDetailsState extends MusicState {}

class MusicNotSearchedState extends MusicState {}

abstract class InternetEvent {}

class InternetLostEvent extends InternetEvent {}

class InternetGainedEvent extends InternetEvent {}

abstract class MusicEvent {}

class MusicSearchedEvent extends MusicEvent {}

class MusicSearchingEvent extends MusicEvent {}

class MusicDetailsEvent extends MusicEvent {}

class MusicNotSearchedEvent extends MusicEvent {}

class MatchStatus {
  final _name;

  const MatchStatus._internal(this._name);

  static const notStarted = const MatchStatus._internal("Not started");
  static const running = const MatchStatus._internal("Running");
  static const ended = const MatchStatus._internal("Ended");

  get name => _name;


}


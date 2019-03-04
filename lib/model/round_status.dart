class RoundStatus {
  final _name;

  const RoundStatus._internal(this._name);

  static const notStarted = const RoundStatus._internal("Not started");
  static const started = const RoundStatus._internal("Started");
  static const ended = const RoundStatus._internal("Ended");

  get name => _name;
}

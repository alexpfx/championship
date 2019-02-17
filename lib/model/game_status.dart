class GameStatus {
  final _name;
  final _defenseInfluence;
  final _attackInfluence;

  const GameStatus._internal(this._name, this._defenseInfluence, this._attackInfluence);

  static const goal = const GameStatus._internal("goal", 0, 0);

  static const changeTeams = const GameStatus._internal("changeTeams", 0, 0);

  static const lastDefense =
      const GameStatus._internal("lastDefense", 0.65, 0.35);
  static const firstDefense =
      const GameStatus._internal("firstDefense", 0.6, 0.4);

  static const middle = const GameStatus._internal("middle", 0.55, 0.45);

  static const neutral = const GameStatus._internal("neutral", 0.5, 0.5);

  get attackInfluence => _attackInfluence;


  get defenseInfluence => _defenseInfluence;

  @override
  String toString() {
    return 'GameStatus{_name: $_name}';
  }
}

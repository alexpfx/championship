class GameStatus {
  final _name;
  final _defenderInfluence;
  final _attackerInfluence;

  const GameStatus._internal(
      this._name, this._defenderInfluence, this._attackerInfluence);

  static const goal = const GameStatus._internal("goal", [0, 0], [0, 0]);

  static const changeTeams =
      const GameStatus._internal("changeTeams", [0, 0], [0, 0]);

  static const lastDefense =
      const GameStatus._internal("lastDefense", [0.8, 0.2], [0.2, 0.8]);
  static const firstDefense =
      const GameStatus._internal("firstDefense", [0.7, 0.3], [0.3, 0.7]);

  static const middle =
      const GameStatus._internal("middle", [0.6, 0.4], [0.4, 0.6]);

  static const neutral =
      const GameStatus._internal("neutral", [0.5, 0.5], [0.5, 0.5]);

  get defenderInfluence => _defenderInfluence;

  get attackerInfluence => _attackerInfluence;

  @override
  String toString() {
    return 'GameStatus{_name: $_name}';
  }


}

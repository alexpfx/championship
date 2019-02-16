class GameStatus {
  final _defenderInfluence;
  final _attackerInfluence;

  const GameStatus._internal(this._defenderInfluence, this._attackerInfluence);


  static const goal = const GameStatus._internal([0, 0], [0, 0]);
  static const changeTeams = const GameStatus._internal([0, 0], [0, 0]);

  static const lastDefense = const GameStatus._internal([0.8, 0.2], [0.1, 0.7]);
  static const firstDefense =
      const GameStatus._internal([0.7, 0.3], [0.2, 0.7]);

  static const middle = const GameStatus._internal([0.6, 0.4], [0.3, 0.7]);

  static const neutral = const GameStatus._internal([0.5, 0.5], [0.5, 0.5]);

  get defenderInfluence => _defenderInfluence;

  get attackerInfluence => _attackerInfluence;

}

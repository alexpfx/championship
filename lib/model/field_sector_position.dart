class SectorStatus {
  final _name;
  final _defenseInfluence;
  final _attackInfluence;

  const SectorStatus._internal(
      this._name, this._defenseInfluence, this._attackInfluence);

  static const goal = const SectorStatus._internal("goal", 0, 0);

  static const changeTeams = const SectorStatus._internal("changeTeams", 0, 0);

  static const lastDefense =
      const SectorStatus._internal("lastDefense", 0.65, 0.35);
  static const firstDefense =
      const SectorStatus._internal("firstDefense", 0.6, 0.4);

  static const middle = const SectorStatus._internal("middle", 0.55, 0.45);

  static const neutral = const SectorStatus._internal("neutral", 0.5, 0.5);

  get attackInfluence => _attackInfluence;

  get defenseInfluence => _defenseInfluence;

  @override
  String toString() {
    return 'GameStatus{_name: $_name}';
  }
}

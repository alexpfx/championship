class Team{
  String _teamName;
  double _attackPower;
  double _defensePower;




  Team(this._teamName, this._attackPower, this._defensePower);

  double get attackPower => _attackPower;

  double get defensePower => _defensePower;

  String get teamName => _teamName;

  @override
  String toString() {
    return 'Team{_teamName: $_teamName';
  }


}
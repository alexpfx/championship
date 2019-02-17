class Team{
  String _teamName;
  double _teamPower;


  Team(this._teamName, this._teamPower);

  double get teamPower => _teamPower;

  String get teamName => _teamName;

  @override
  String toString() {
    return 'Team{_teamName: $_teamName';
  }


}
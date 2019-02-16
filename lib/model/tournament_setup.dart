import 'package:championship/model/team.dart';

class TournamentSetup {
  List<Team> _teams;
  TournamentRoundMode _roundMode;
  TournamentType _type;

  List<Team> get teams => _teams;

  TournamentSetup(this._roundMode, this._type, this._teams);

  TournamentType get type => _type;

  TournamentRoundMode get roundMode => _roundMode;

  TournamentSetup.name(this._teams, this._roundMode, this._type);


}

enum TournamentRoundMode {
  single,
  double,
}

enum TournamentType { league, knockout, group }

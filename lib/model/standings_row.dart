import 'package:championship/model/match_info.dart';

class StandingsRow {
  String _team;

  int _position = 0;


  int _matchPlayed = 0;

  int _wins = 0;

  int _draws = 0;

  int _loses = 0;

  int _goalsFor = 0;

  int _goalsAgainst = 0;

  int _goalsDifference = 0;

  int _points = 0;

  String get team => _team;

  int get goalsFor => _goalsFor;

  int get wins => _wins;

  int get matchPlayed => _matchPlayed;

  int get loses => _loses;

  int get goalsAgainst => _goalsAgainst;

  int get goalsDifference => _goalsDifference;

  int get draws => _draws;

  int get points => _points;

  int get position => _position;

  set position(int value) {
    _position = value;
  }


  StandingsRow(this._team);

  void update(MatchResult result) {
    updateWDL(result);
    _goalsFor += result.goals;
    _goalsAgainst += result.goalsAgainst;
    _points += result.points;
    _matchPlayed++;
    _goalsDifference += (result.goals - result.goalsAgainst);
  }

  void updateWDL(MatchResult result) {
    if (result.points == 1) {
      _draws++;
    } else if (result.points == 3) {
      _wins++;
    } else {
      _loses++;
    }
  }

  @override
  String toString() {
    return 'StandingsRow{_team: $_team, _matchPlayed: $_matchPlayed, _wins: $_wins, _draws: $_draws, _loses: $_loses, _goalsFor: $_goalsFor, _goalsAgainst: $_goalsAgainst, _goalsDifference: $_goalsDifference, _points: $_points}';
  }
}

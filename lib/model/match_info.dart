import 'package:championship/model/team.dart';

class MatchInfo {
  String _name;
  Team _homeTeam;
  Team _awayTeam;
  int _homeScore;
  int _awayScore;
  bool _finished = false;






  MatchInfo({String info, homeTeam, awayTeam, homeScore, awayScore})
      : _name = info,
        _homeTeam = homeTeam,
        _awayTeam = awayTeam,
        _homeScore = homeScore,
        _awayScore = awayScore
  ;

  Team get awayTeam => _awayTeam;

  Team get homeTeam => _homeTeam;

  int get awayScore => _awayScore;

  int get homeScore => _homeScore;


  updateScores(homeTeamScore, awayTeamScore) {
    _homeScore = homeTeamScore;
    _awayScore = awayTeamScore;
  }

  String get name => _name;

  @override
  String toString() {
    return 'Match{_homeTeam: $_homeTeam, _awayTeam: $_awayTeam}';
  }


  MatchResult getHomeResult(){
    int points = _homeScore == awayScore? 1: _homeScore > _awayScore? 3: 0;
    return MatchResult(_homeScore, _awayScore, points , _homeTeam);
  }

  MatchResult getAwayResult(){
    int points = _homeScore == awayScore? 1: _homeScore < _awayScore? 3: 0;
    return MatchResult(_awayScore, _homeScore, points , _awayTeam);
  }

  bool get finished => _finished;

  set finished(bool finalized) {
    _finished = finalized;
  }


}

class MatchResult {
  int _goals;
  int _points;
  Team _team;

  var _goalsAgainst;

  MatchResult(this._goals, this._goalsAgainst, this._points, this._team);

  Team get team => _team;

  int get points => _points;

  int get goals => _goals;

  int get goalsAgainst => _goalsAgainst;


}
import 'package:championship/model/match_info.dart';

class MatchEvent {
  int _homeTeamScore;
  int _awayTeamScore;
  int _minute;

  MatchInfo _match;

  int get homeTeamScore => _homeTeamScore;

  int get awayTeamScore => _awayTeamScore;

  int get minute => _minute;


  MatchEvent(this._homeTeamScore, this._awayTeamScore, this._match, this._minute);

  MatchInfo get match => _match;

  addHomeScore() {
    _homeTeamScore++;
    return this;
  }

  addAwayScore() {
    _awayTeamScore++;
    return this;
  }

  @override
  String toString() {
    return 'MatchEvent{_homeTeamScore: $_homeTeamScore, _awayTeamScore: $_awayTeamScore, _minute: $_minute, _match: $_match}';
  }


}

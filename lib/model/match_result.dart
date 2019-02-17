import 'package:championship/model/match_info.dart';

class MatchResult {
  int _homeTeamScore;
  int _awayTeamScore;

  MatchInfo _match;

  bool _finished = false;

  bool get isFinished => _finished;

  int get homeTeamScore => _homeTeamScore;

  int get awayTeamScore => _awayTeamScore;

  MatchResult(this._homeTeamScore, this._awayTeamScore, this._match);

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
    return 'MatchResult{_homeTeamScore: $_homeTeamScore, _awayTeamScore: $_awayTeamScore, _finished: $_finished}';
  }

  void finishGame() {
    _finished = true;

    _match.updateScores(homeTeamScore, awayTeamScore);
  }
}

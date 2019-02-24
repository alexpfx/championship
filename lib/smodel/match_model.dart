import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/model/match_status.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class MatchModel extends Model {
  int _totalTime;

  MatchStatus _matchStatus = MatchStatus.notStarted;

  var _currentTime = 0;

  MatchModel(this._matchInfo) {
    _gameSimulator = MatchSimulator(_matchInfo);
  }

  MatchSimulator _gameSimulator;
  MatchInfo _matchInfo;

  MatchEvent _lastEvent;

  MatchEvent get lastEvent => _lastEvent;

  String get matchName => _matchInfo.name;

  String get homeTeamName => _matchInfo.homeTeam.teamName;

  String get awayTeamName => _matchInfo.awayTeam.teamName;

  int get time => _currentTime;

  MatchStatus get status => _matchStatus;


  void initialize(int minutes) {
    _totalTime = minutes;
    _gameSimulator.startSimulation((matchEvent) {
      _lastEvent = matchEvent;
    });
  }

  void stepGame() {
    _currentTime = _gameSimulator.step();
    if (MatchStatus.notStarted == _matchStatus){
      _matchStatus = MatchStatus.running;
    }

    if (_currentTime >= _totalTime) {
      _matchStatus = MatchStatus.ended;
    }
    notifyListeners();
  }

  get finished => MatchStatus.ended == _matchStatus;

  static MatchModel of(BuildContext context) {
    return ScopedModel.of<MatchModel>(context);
  }
}

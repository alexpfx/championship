import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class MatchModel extends Model {
  int _minutes;

  var _finished = false;
  MatchModel(this._matchInfo) {
    _gameSimulator = MatchSimulator(_matchInfo);
  }

  MatchSimulator _gameSimulator;
  MatchInfo _matchInfo;

  MatchEvent _lastEvent;

  MatchEvent get lastEvent => _lastEvent;

  MatchInfo get matchInfo => _matchInfo;

  void initialize(int minutes) {
    _minutes = minutes;
    _gameSimulator.startSimulation((matchEvent) {
      _lastEvent = matchEvent;
    });
  }

  void stepGame() {
    var currentTime = _gameSimulator.step();

    if (currentTime >= _minutes){
      _finished = true;
    }
    notifyListeners();

  }

  get finished => _finished;

  static MatchModel of(BuildContext context){
    return ScopedModel.of<MatchModel>(context);
  }
}

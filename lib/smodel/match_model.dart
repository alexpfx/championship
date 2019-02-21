import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:scoped_model/scoped_model.dart';

class MatchModel extends Model {
  MatchModel(this._matchInfo) {
    _gameSimulator = MatchSimulator(_matchInfo);
  }

  MatchSimulator _gameSimulator;
  MatchInfo _matchInfo;

  MatchEvent _lastEvent;

  MatchEvent get lastEvent => _lastEvent;

  MatchInfo get matchInfo => _matchInfo;

  void startSimulation(int minutes) {
    _gameSimulator.startSimulation((matchEvent) {
      print(matchEvent);
      _lastEvent = matchEvent;
      notifyListeners();
    }, minutes);
    notifyListeners();

    stepGame();
  }

  void stepGame() {
    while (!_gameSimulator.isFinished()) {
      _gameSimulator.step();
    }
  }
}

import 'package:championship/service/game_simulator.dart';
import 'package:scoped_model/scoped_model.dart';

class MatchModel extends Model {
  GameSimulator _gameSimulator;

  void startSimulation(int minutes) {
    _gameSimulator.startSimulation((matchResult) {
      print(matchResult);
    }, minutes);

    notifyListeners();
  }

  void stepGame() {
    _gameSimulator.step();
    notifyListeners();
  }
}

import 'dart:math';

import 'package:championship/model/game_status.dart';
import 'package:championship/model/match.dart';
import 'package:championship/model/team.dart';
import 'package:kernel/text/serializer_combinators.dart';

class GameSimulator {
  GameStatus _gameStatus;
  static List<GameStatus> _order = [
    GameStatus.goal,
    GameStatus.lastDefense,
    GameStatus.firstDefense,
    GameStatus.middle,
    GameStatus.neutral,
    GameStatus.changeTeams
  ];

  int _totalMinutes = 90;

  Match _match;

  Random _random = Random();

  GameSimulator(this._gameStatus, this._totalMinutes, this._match);

  startSimulation() {
    Team homeTeam = _match.homeTeam;
    Team awayTeam = _match.awayTeam;
    Team attacker = homeTeam;
    Team defender = awayTeam;

    for (int i = 0; i < _totalMinutes; i++) {
      _gameStatus = simulate(attacker, defender);

      if (GameStatus.goal == _gameStatus) {
        _sendGoal(attacker);
      }

      if (GameStatus.changeTeams == _gameStatus ||
          GameStatus.goal == _gameStatus) {
        var temp = attacker;
        defender = attacker;
        attacker = temp;
      }

    }
  }

  GameStatus simulate(Team attacker, Team defender) {
    double at = _random.nextInt(1000) *
        (_gameStatus.attackerInfluence[0] * attacker.attackPower +
            _gameStatus.attackerInfluence[1] * attacker.defensePower);

    double df = _random.nextInt(1000) *
        (_gameStatus.attackerInfluence[0] * defender.attackPower +
            _gameStatus.attackerInfluence[1] * defender.defensePower);

    _gameStatus = (at > df) ? prev(_gameStatus) : next(_gameStatus);

    return _gameStatus;
  }

  GameStatus prev(GameStatus status) => _order[_order.indexOf(status) - 1];

  GameStatus next(GameStatus status) => _order[_order.indexOf(status) + 1];

  void _sendGoal(Team attacker) {
    print("goal: ${attacker.teamName}");
  }

  Tuple2<Team, Team> _swapTeams(Team attacker, Team defender) {
    return Tuple2(defender, attacker);
  }
}

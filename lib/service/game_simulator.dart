import 'dart:math' as math;

import 'package:championship/model/game_status.dart';
import 'package:championship/model/match.dart';
import 'package:championship/model/team.dart';

class GameSimulator {
  static const delta = 2;
  GameStatus _gameStatus = GameStatus.neutral;
  static List<GameStatus> _order = [
    GameStatus.goal,
    GameStatus.lastDefense,
    GameStatus.firstDefense,
    GameStatus.middle,
    GameStatus.neutral,
    GameStatus.changeTeams
  ];

  static const _totalMinutes = 90;

  MatchInfo _match;

  math.Random _random = math.Random.secure();

  Team attacker;

  Team defender;

  GameSimulator(this._match);

  startSimulation() {
    Team homeTeam = _match.homeTeam;
    Team awayTeam = _match.awayTeam;

    chooseSides(homeTeam, awayTeam);

    for (int i = 0; i < _totalMinutes; i++) {
      _gameStatus = _simulate(attacker, defender);

      if (GameStatus.goal == _gameStatus) {
        _sendGoal(attacker);
      }

      if (GameStatus.changeTeams == _gameStatus ||
          GameStatus.goal == _gameStatus) {
        changeBallControll();

        _gameStatus = GameStatus.neutral;
      }
    }
  }

  void changeBallControll() {
    var temp = defender;
    defender = attacker;
    attacker = temp;
  }

  static const divider = 2;

  GameStatus _simulate(Team attacker, Team defender) {
    var randomAt = _random.nextDouble();
    double at = randomAt *
        (_gameStatus.attackerInfluence[0] * (attacker.attackPower / divider) +
            _gameStatus.attackerInfluence[1] *
                (attacker.defensePower / divider));

    var randomDf = _random.nextDouble();
    double df = randomDf *
        (_gameStatus.defenderInfluence[0] * (defender.attackPower / divider) +
            _gameStatus.defenderInfluence[1] *
                (defender.defensePower / divider));

    return _compareGameStatus(at, df, _gameStatus);
  }

  GameStatus _compareGameStatus(double at, double df, GameStatus _gameStatus) {
    var diff = (at - df).abs();

    if (diff <= delta) {
      return _gameStatus;
    }

    return (at > df) ? _prev(_gameStatus): _next(_gameStatus);
  }

  GameStatus _prev(GameStatus status) => _order[_order.indexOf(status) - 1];

  GameStatus _next(GameStatus status) => _order[_order.indexOf(status) + 1];

  void _sendGoal(Team attacker) {
    print("goal: ${attacker.teamName}");
  }

  void chooseSides(Team homeTeam, Team awayTeam) {
    if (_random.nextDouble() > 0.5) {
      attacker = homeTeam;
      defender = awayTeam;
    } else {
      attacker = awayTeam;
      defender = homeTeam;
    }
  }
}

import 'dart:math' as math;

import 'package:championship/model/game_status.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/model/team.dart';

class GameSimulator {
  static const delta = 0.01;
  static const randomWeight = 0.9;
  static const powerWeight = 0.5;
  static const totalMinutes = 90;
  static List<GameStatus> _order = [
    GameStatus.goal,
    GameStatus.lastDefense,
    GameStatus.firstDefense,
    GameStatus.middle,
    GameStatus.neutral,
    GameStatus.changeTeams
  ];

  GameStatus _gameStatus = GameStatus.neutral;
  MatchResult _matchResult;
  MatchInfo _match;

  math.Random _random = math.Random(DateTime.now().millisecondsSinceEpoch);

  Team _attacker;
  Team _defender;

  GameSimulator(this._match);

  startSimulation([Function(MatchResult) goalCallback]) {
    _matchResult = MatchResult(0, 0, _match);

    Team homeTeam = _match.homeTeam;
    Team awayTeam = _match.awayTeam;

    chooseSides(homeTeam, awayTeam);

    for (int i = 0; i < totalMinutes; i++) {
      _gameStatus = _simulate(_attacker, _defender);

      if (GameStatus.goal == _gameStatus) {
        _sendGoal(_attacker, goalCallback);
      }

      if (GameStatus.changeTeams == _gameStatus ||
          GameStatus.goal == _gameStatus) {
        changeBallControll();

        _gameStatus = GameStatus.neutral;
      }
    }

    _matchResult.finishGame();
    print(_matchResult);

//    print("media casa: ${goals[homeTeam.teamName] / (totalMinutes / 90)}", );
//    print("media fora: ${goals[awayTeam.teamName] / (totalMinutes / 90)}", );
  }

  void changeBallControll() {
    var temp = _defender;
    _defender = _attacker;
    _attacker = temp;
  }

  GameStatus _simulate(Team attacker, Team defender) {
    double rAtt = (_random.nextInt(9) + 1).toDouble() / 10;
    double at = rAtt * randomWeight +
        (attacker.teamPower / 100) * _gameStatus.attackInfluence * powerWeight;

    double rDef = (_random.nextInt(9) + 1).toDouble() / 10;
    double df = rDef * randomWeight +
        (defender.teamPower / 100) * _gameStatus.defenseInfluence * powerWeight;

    double luckFactorAtt = _random.nextDouble() * 1.3;
    double luckFactorDef = _random.nextDouble() * 1.4;
    return _compareGameStatus(
        at + luckFactorAtt, df + luckFactorDef, _gameStatus);
  }

  GameStatus _compareGameStatus(double at, double df, GameStatus _gameStatus) {
    var diff = (at - df).abs();

    if (diff <= delta) {
      return _gameStatus;
    }

    return (at > df) ? _prev(_gameStatus) : _next(_gameStatus);
  }

  GameStatus _prev(GameStatus status) => _order[_order.indexOf(status) - 1];

  GameStatus _next(GameStatus status) => _order[_order.indexOf(status) + 1];

  Map<String, int> goals = {};

  void _sendGoal(Team attacker, [Function(MatchResult) goalCallback]) {
    if (attacker == _match.homeTeam) {
      _matchResult.addHomeScore();
    } else {
      _matchResult.addAwayScore();
    }
    if (goalCallback != null) {
      goalCallback(_matchResult);
    }
  }

  void chooseSides(Team homeTeam, Team awayTeam) {
    if (_random.nextBool()) {
      _attacker = homeTeam;
      _defender = awayTeam;
    } else {
      _attacker = awayTeam;
      _defender = homeTeam;
    }
  }
}

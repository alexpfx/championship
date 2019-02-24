import 'dart:math' as math;

import 'package:championship/model/field_sector_position.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/model/team.dart';

class MatchSimulator {
  static const _delta = 0.01;
  static const _randomWeight = 0.9;
  static const _powerWeight = 0.5;

  static List<SectorStatus> _order = [
    SectorStatus.goal,
    SectorStatus.lastDefense,
    SectorStatus.firstDefense,
    SectorStatus.middle,
    SectorStatus.neutral,
    SectorStatus.changeTeams
  ];

  SectorStatus _ballPosition = SectorStatus.neutral;
  MatchInfo _match;

  math.Random _random = math.Random(DateTime.now().millisecondsSinceEpoch);

  Team _attacker;
  Team _defender;
  int _currentTime = 0;
  int _homeTeamScore = 0;
  int _awayTeamScore = 0;

  Function(MatchEvent) _matchEventCallback;

  MatchSimulator(this._match);

  startSimulation(Function(MatchEvent) matchEventCallback) {
    this._matchEventCallback = matchEventCallback;

    Team homeTeam = _match.homeTeam;
    Team awayTeam = _match.awayTeam;

    chooseSides(homeTeam, awayTeam);
  }

  _simulate() {
    _ballPosition = _updateBallPosition(_attacker, _defender);

    if (SectorStatus.goal == _ballPosition) {
      _sendGoal(_attacker);
    }

    if (SectorStatus.changeTeams == _ballPosition ||
        SectorStatus.goal == _ballPosition) {
      changeBallControll();

      _ballPosition = SectorStatus.neutral;
    }
  }

  int step() {
    _simulate();

    return _currentTime++;
  }

  void changeBallControll() {
    var temp = _defender;
    _defender = _attacker;
    _attacker = temp;
  }

  SectorStatus _updateBallPosition(Team attacker, Team defender) {
    double rAtt = (_random.nextInt(9) + 1).toDouble() / 10;
    double at = rAtt * _randomWeight +
        (attacker.teamPower / 100) *
            _ballPosition.attackInfluence *
            _powerWeight;

    double rDef = (_random.nextInt(9) + 1).toDouble() / 10;
    double df = rDef * _randomWeight +
        (defender.teamPower / 100) *
            _ballPosition.defenseInfluence *
            _powerWeight;

    double luckFactorAtt = _random.nextDouble() * 1.3;
    double luckFactorDef = _random.nextDouble() * 1.4;
    return _comparePosition(
        at + luckFactorAtt, df + luckFactorDef, _ballPosition);
  }

  SectorStatus _comparePosition(
      double at, double df, SectorStatus _gameStatus) {
    var diff = (at - df).abs();

    if (diff <= _delta) {
      return _gameStatus;
    }

    return (at > df) ? _prev(_gameStatus) : _next(_gameStatus);
  }

  SectorStatus _prev(SectorStatus status) => _order[_order.indexOf(status) - 1];

  SectorStatus _next(SectorStatus status) => _order[_order.indexOf(status) + 1];

  Map<String, int> goals = {};

  void _sendGoal(Team attacker) {
    if (attacker == _match.homeTeam) {
      _homeTeamScore++;
    } else {
      _awayTeamScore++;
    }
    _matchEventCallback(
        MatchEvent(_homeTeamScore, _awayTeamScore, _match, _currentTime));
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

import 'dart:math' as math;

import 'package:championship/model/game_status.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/model/team.dart';

enum Status {
  created,
  running,
  finished
}


class MatchSimulator {
  
  Status _matchStatus;
  
  static const delta = 0.01;
  static const randomWeight = 0.9;
  static const powerWeight = 0.5;

  static List<BallPosition> _order = [
    BallPosition.goal,
    BallPosition.lastDefense,
    BallPosition.firstDefense,
    BallPosition.middle,
    BallPosition.neutral,
    BallPosition.changeTeams
  ];

  int totalMinutes;
  BallPosition _ballPosition = BallPosition.neutral;
  MatchEvent _matchEvent;
  MatchInfo _match;

  math.Random _random = math.Random(DateTime.now().millisecondsSinceEpoch);

  Team _attacker;
  Team _defender;
  int currentTime = 0;

  Function(MatchEvent) _matchEventCallback;

  MatchSimulator(this._match);

  startSimulation(Function(MatchEvent) matchEventCallback, int minutes) {
    if (_matchStatus != null){
      return;
    }

    totalMinutes = minutes;
    this._matchEventCallback = matchEventCallback;
    _matchEvent = MatchEvent(0, 0, _match, 0);

    Team homeTeam = _match.homeTeam;
    Team awayTeam = _match.awayTeam;

    chooseSides(homeTeam, awayTeam);

    _matchStatus = Status.created;
  }

  _simulate() {
    _ballPosition = _updateBallPosition(_attacker, _defender);

    if (BallPosition.goal == _ballPosition) {
      _sendGoal(_attacker);
    }

    if (BallPosition.changeTeams == _ballPosition ||
        BallPosition.goal == _ballPosition) {
      changeBallControll();

      _ballPosition = BallPosition.neutral;
    }
  }


  step() {
    print(_matchStatus);
    if (_matchStatus == Status.finished){
      return;
    }

    _matchStatus = Status.running;
    currentTime++;
    _simulate();
    if (currentTime >= totalMinutes) {
      _matchEvent.finishGame();
      _matchStatus = Status.finished;

      _matchEventCallback(_matchEvent);
    }

  }

  void changeBallControll() {
    var temp = _defender;
    _defender = _attacker;
    _attacker = temp;
  }

  BallPosition _updateBallPosition(Team attacker, Team defender) {
    double rAtt = (_random.nextInt(9) + 1).toDouble() / 10;
    double at = rAtt * randomWeight +
        (attacker.teamPower / 100) * _ballPosition.attackInfluence * powerWeight;

    double rDef = (_random.nextInt(9) + 1).toDouble() / 10;
    double df = rDef * randomWeight +
        (defender.teamPower / 100) * _ballPosition.defenseInfluence * powerWeight;

    double luckFactorAtt = _random.nextDouble() * 1.3;
    double luckFactorDef = _random.nextDouble() * 1.4;
    return _comparePosition(
        at + luckFactorAtt, df + luckFactorDef, _ballPosition);
  }

  BallPosition _comparePosition(double at, double df, BallPosition _gameStatus) {
    var diff = (at - df).abs();

    if (diff <= delta) {
      return _gameStatus;
    }

    return (at > df) ? _prev(_gameStatus) : _next(_gameStatus);
  }

  BallPosition _prev(BallPosition status) => _order[_order.indexOf(status) - 1];

  BallPosition _next(BallPosition status) => _order[_order.indexOf(status) + 1];

  Map<String, int> goals = {};

  void _sendGoal(Team attacker) {
    if (attacker == _match.homeTeam) {
      _matchEvent.addHomeScore();
    } else {
      _matchEvent.addAwayScore();
    }
    _matchEventCallback(_matchEvent);
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

  bool isFinished() {
    return _matchStatus == Status.finished;

  }
}

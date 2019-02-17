import 'package:championship/model/match_info.dart';
import 'package:championship/model/team.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:test/test.dart';

void main() {
  GameSimulator gameSimulator;

  setUp(() {
    MatchInfo match = MatchInfo(
        homeTeam: Team("Gremio", 90),
        awayTeam: Team("Internacional", 80),
        homeScore: 0,
        awayScore: 0);
    gameSimulator = GameSimulator(match);
  });

  test("simulate", () {
    gameSimulator.startSimulation();

    gameSimulator.startSimulation((e) => e);
  });
}

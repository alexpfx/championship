import 'package:championship/model/match_info.dart';
import 'package:championship/model/team.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:test/test.dart';

void main() {
  MatchSimulator gameSimulator;

  setUp(() {
    MatchInfo match = MatchInfo(
        homeTeam: Team("Gremio", 90),
        awayTeam: Team("Internacional", 80),
        homeScore: 0,
        awayScore: 0);
    gameSimulator = MatchSimulator(match);
  });

  test("simulate", () {
    print("\n");
    gameSimulator.startSimulation((e) => print(e));

    for (int i = 0; i < 90; i++) {
      gameSimulator.step();
    }

  });

  test("simulate120min", () {
    print("\n");
    gameSimulator.startSimulation((e) => print(e));

    for (int i = 0; i < 120; i++) {
      gameSimulator.step();
    }

  });



}

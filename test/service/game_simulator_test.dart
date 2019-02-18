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
    gameSimulator.startSimulation((e) => print(e), 90);

    for (int i = 0; i < 90; i++) {
      gameSimulator.step();
    }

  });

  test("callwhengamefinish", () {
    gameSimulator.startSimulation((e) => print(e), 90);

    while(gameSimulator.step()) {
      // run until end
    }

    expect(() => gameSimulator.step(), throwsA(TypeMatcher<StateError>()));


  });
}

import 'package:championship/model/match.dart';
import 'package:championship/model/team.dart';
import 'package:championship/service/game_simulator.dart';
import 'package:championship/model/game_status.dart';

import 'package:test/test.dart';


void main() {
  
  GameSimulator gameSimulator;

  setUp((){
    
    MatchInfo match = MatchInfo(homeTeam: Team("Gremio", 80, 80), awayTeam: Team("Internacional", 90, 60), homeScore: 0, awayScore: 0);
    gameSimulator = GameSimulator(match);
  });
  
  test("simulate", () {
    gameSimulator.startSimulation();
  });
}

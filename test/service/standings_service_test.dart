

import 'package:championship/service/standings_service.dart';

import 'package:test/test.dart';

import 'test_util.dart' as testUtil;

void main(){

  test("buildStandings", () {
    var rounds = testUtil.getRounds(3);
    rounds.forEach((r){
      r.matches.forEach((m){
        m.updateScores(2, 2);
        m.finished = true;
      });
    });

    var srList = buildStandingsRows(rounds);
    srList.sort((sr1, sr2){
      return sr2.points.compareTo(sr1.points);
    });

    srList.forEach((sr){
      print(sr);
    });




  });
}
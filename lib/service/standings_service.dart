import 'package:championship/model/round.dart';
import 'package:championship/model/standings_row.dart';
import 'package:championship/model/team.dart';

List<StandingsRow> buildStandingsRows(List<Round> rounds) {
  Map<Team, StandingsRow> sMap = {};

  for (var round in rounds) {
    for (var match in round.matches) {
      if (match.finished) {
        final homeTeam = match.homeTeam;
        final awayTeam = match.awayTeam;
        print(homeTeam);
        print(awayTeam);
        sMap.putIfAbsent(homeTeam, () => StandingsRow(homeTeam.teamName));
        sMap.putIfAbsent(awayTeam, () => StandingsRow(awayTeam.teamName));

        sMap[homeTeam].update(match.getHomeResult());
        sMap[awayTeam].update(match.getAwayResult());
      }
    }
  }

  return sMap.values.toList();
}

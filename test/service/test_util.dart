import 'package:championship/tournament_builder.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/round.dart';
import 'package:championship/model/team.dart';
import 'package:championship/model/tournament_setup.dart';

Team getTeam(String name) {
  return Team(name, 70);
}

MatchInfo getMatch(String homeTeam, String awayTeam) {
  return MatchInfo(
      info: "match x",
      homeTeam: getTeam(homeTeam),
      awayTeam: getTeam(awayTeam),
      awayScore: 0,
      homeScore: 0);
}

TournamentSetup getFakeTournamentSetup(int numberOfTeams) {
  List<Team> teams = [];

  for (int i = 0; i < numberOfTeams; i++) {
    teams.add(getTeam("team $i"));
  }
  return TournamentSetup(
      TournamentRoundMode.single, TournamentType.league, teams);
}

List<Round> getRounds(int teams) {
  var setup = getFakeTournamentSetup(teams);

  return buildTournament(setup);
}

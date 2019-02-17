import 'package:championship/model/match.dart';
import 'package:championship/model/round.dart';
import 'package:championship/model/team.dart';
import 'package:championship/model/tournament_setup.dart';

List<Round> _buildGroupTournament(TournamentSetup setup) {
  return [];
}

Team _dummyTeam = Team(null, null, null);

List<Round> buildTournament(TournamentSetup setup) {
  if (TournamentType.league == setup.type) {
    return _buildLeagueTournament(setup);
  }

  return null;
}

List<Round> _buildLeagueTournament(TournamentSetup setup) {
  var teams = List.of(setup.teams);

  if (teams.length.isOdd) {
    teams.add(_dummyTeam);
  }

  int size = teams.length;
  int mid = (size ~/ 2);

  List<Round> rounds = [];

  for (int i = 1; i < size; i++) {
    var roundMatches = <MatchInfo>[];
    for (int j = 0; j < mid; j++) {
      var home = teams[j];
      var away = teams[(size - 1) - j];
      var match =
          MatchInfo(homeTeam: home, awayTeam: away, homeScore: 0, awayScore: 0);
      print('${home.teamName} x ${away.teamName}');
      roundMatches.add(match);
    }
    print('\n');
    var r = Round(roundMatches);
    rounds.add(r);
    teams = _rotate(teams, 0);
  }

  return _cleanUp(rounds);
}

List<Round> _cleanUp(List<Round> rounds) {
  rounds.forEach((r) {
    var matches = r.matches;
    int index = 0;
    for (int i = 0; i < matches.length; i++) {
      MatchInfo m = matches[i];
      if (m.homeTeam == _dummyTeam || m.awayTeam == _dummyTeam) {
        matches.removeAt(i);
      } else {
        index++;
        m.info = "Match $index";
      }
    }
  });

  return List.of(rounds);
}

List<Team> _rotate(List<Team> teams, int saveIndex) {
  var save = teams.removeAt(saveIndex);
  var last = teams.removeLast();
  teams.insert(0, last);
  teams.insert(saveIndex, save);
  return List.of(teams);
}

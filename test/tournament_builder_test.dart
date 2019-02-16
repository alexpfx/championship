// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:championship/model/round.dart';
import 'package:championship/model/team.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/tournament_builder.dart';
import 'package:test/test.dart';

void main() {
//  test('buildLeagueTournament0', () {
//    var teams = [
//      Team('Gremio', 100),
//      Team('Inter', 99),
//      Team('Fluminense', 98),
//      Team('Flamengo', 97),
//      Team('Avai', 96),
//      Team('Figueirense', 95)
//    ];
//
//    var setup = TournamentSetup(
//        TournamentRoundMode.single, TournamentType.league, teams);
//
//    List<Round> r = buildTournament(setup);
//
//    expect(r, isNotNull);
//    expect(5, r.length);
//    var sum = r.map((r) => r.matches.length).reduce((l1, l2) => l1 + l2);
//    expect(15, sum);
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Gremio';
//          }).length);
//    });
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Inter' ||
//                (m as Match).awayTeam.teamName == 'Inter';
//          }).length);
//    });
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Fluminense' ||
//                (m as Match).awayTeam.teamName == 'Fluminense';
//          }).length);
//    });
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Flamengo' ||
//                (m as Match).awayTeam.teamName == 'Flamengo';
//          }).length);
//    });
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Avai' ||
//                (m as Match).awayTeam.teamName == 'Avai';
//          }).length);
//    });
//
//    r.forEach((Round round) {
//      expect(
//          1,
//          round.matches.where((m) {
//            return (m as Match).homeTeam.teamName == 'Figueirense' ||
//                (m as Match).awayTeam.teamName == 'Figueirense';
//          }).length);
//    });
//  });
//
//
//
//  test('buildLeagueTournament', () {
//    var teams = [
//      Team('Gremio', 100),
//      Team('Inter', 99),
//      Team('Fluminense', 98),
//      Team('Flamengo', 97),
//      Team('Avai', 96),
//      Team('Figueirense', 95),
//      Team('Madureira', 94),
////      Team('Tubarao', 93)
//    ];
//
//    var setup = TournamentSetup(
//        TournamentRoundMode.single, TournamentType.league, teams);
//
//    List<Round> rounds = buildTournament(setup);
//
//    expect(rounds, isNotNull);
//    expect(7, rounds.length);
//
//    int matchCount = countMatchs(rounds);
//
//    expect(expectedNrOfMatches(teams), matchCount);
//  });

  test('buildLeagueTournament3', () {
    var teams = [
      Team('Gremio', 100, 70),
      Team('Inter', 99, 70),
      Team('Fluminense', 98, 70),
      Team('Avai', 96, 70),
      Team('Flamengo', 97, 70),

//      Team('Tubarao', 93)
    ];

    var setup = TournamentSetup(
        TournamentRoundMode.single, TournamentType.league, teams);

    List<Round> rounds = buildTournament(setup);

    expect(rounds, isNotNull);
    expect(5, rounds.length);

    int matchCount = countMatchs(rounds);

    expect(expectedNrOfMatches(teams), matchCount);
  });
}

int expectedNrOfMatches(List<Team> teams) {
  return ((teams.length / 2) * (teams.length - 1)).round();
}

int countMatchs(List<Round> rounds) {
  return rounds.map((r) => r.matches.length).reduce((l1, l2) => l1 + l2);
}

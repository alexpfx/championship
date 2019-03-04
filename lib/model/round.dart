import 'dart:math';

import 'package:championship/model/match_info.dart';
import 'package:championship/model/tournament_setup.dart';

class Round {
  List<MatchInfo> _matches;
  Random _random = Random.secure();
  List<MatchInfo> get matches => _matches;

  String _name;

  TournamentSetup _tournamentSetup;

  String get name => _name;

  Round(this._matches, this._name, this._tournamentSetup);

  TournamentSetup get tournamentSetup => _tournamentSetup;

  @override
  String toString() {
    return 'Round{_matches: $_matches}';
  }

  void shuffleMatchs() {
    _matches.shuffle();
  }

  void shuffleHomeTeam() {
    _matches.forEach((m) {
      if (_random.nextBool()){
        m.swapHomeTeam();
      }
    });
  }

}

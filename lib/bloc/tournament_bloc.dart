import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/model/round.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/tournament_builder.dart';

class TournamentBloc implements BlocBase {
  var _controller = StreamController<List<Round>>();

  Stream<List<Round>> get outRoundCreator => _controller.stream.asBroadcastStream();

  StreamController<TournamentSetup> _inputController =
      StreamController<TournamentSetup>();

  Sink<TournamentSetup> get inputTournamentSetup => _inputController.sink;

  @override
  void dispose() {
    _controller.close();
    _inputController.close();
  }

  TournamentBloc() {
    _inputController.stream.asBroadcastStream().listen(_tournamentSetup);
  }

  void _tournamentSetup(TournamentSetup setup) {
    if (TournamentType.league == setup.type) {
      List<Round> rounds = buildTournament (setup);
      _controller.sink.add(rounds);
    }

  }



}

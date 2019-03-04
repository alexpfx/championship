import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/service/game_simulator.dart';

class MatchSimulatorBloc implements BlocBase {
  final StreamController<MatchInfo> _matchController =
      StreamController<MatchInfo>();
  final StreamController<MatchEvent> _matchEventController =
      StreamController<MatchEvent>();

  final StreamController<MatchSimulator> _matchSimulatorController =
      StreamController<MatchSimulator>();

  Sink<MatchInfo> get inMatchInfo => _matchController.sink;

  Stream<MatchEvent> get outMatchEvent =>
      _matchEventController.stream.asBroadcastStream();

  MatchSimulatorBloc() {
    _matchController.stream.asBroadcastStream().listen(_onMatchAdd);
  }

  @override
  void dispose() {
    _matchController.close();
    _matchEventController.close();
    _matchSimulatorController.close();
  }

  void _onMatchAdd(MatchInfo match) {
    MatchSimulator s = new MatchSimulator(match);
    _matchSimulatorController.add(s);
  }
}

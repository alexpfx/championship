import 'package:championship/model/round.dart';
import 'package:championship/model/round_status.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class RoundModel extends Model {
  static RoundModel of(BuildContext context) =>
      ScopedModel.of<RoundModel>(context);

  final Round _round;

  RoundStatus _roundStatus = RoundStatus.notStarted;

  RoundModel(this._round) {
    initialize();
  }

  bool _started = false;

  bool get started => _started;

  Round get round => _round;

  List<MatchModel> matchs = [];

  int get length => matchs.length;

  String get name => _round.name;

  int get numberOfMatches => matchs.length;

  MatchModel matchAt(int index) => matchs[index];

  RoundStatus get roundStatus => _roundStatus;

  initialize() {
    _started = true;
    var mInfos = round.matches;
    for (var match in mInfos) {
      var mm = MatchModel(match);
      mm.addListener(_countActiveMatches);
      mm.initialize(90);
      matchs.add(mm);
    }
  }

  runTheGame() {
    if (RoundStatus.started == _roundStatus) {
      return;
    }
    _roundStatus = RoundStatus.started;
    var notFinishedMatchs = matchs.where((m) => !m.finished);

    notFinishedMatchs.forEach((m) {
      m.runGame();
    });

    notifyListeners();
    print('runTheGame ${_roundStatus.name}');
  }

  void _countActiveMatches() {
    int countFinished = matchs.where((m) => !m.finished).toList().length;
    if (countFinished == 0) {
      _roundStatus = RoundStatus.ended;
    }
    notifyListeners();
  }
}

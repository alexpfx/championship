import 'package:championship/model/round.dart';
import 'package:championship/model/standings_row.dart';
import 'package:championship/service/standings_service.dart';
import 'package:scoped_model/scoped_model.dart';

class StandingsModel extends Model {

  List<StandingsRow> _rows = [];

  List<StandingsRow> get rows => _rows;

  update(List<Round> rounds) {
    int x = 0;

    _rows = buildStandingsRows(rounds);
    _rows.sort((a,b){
      return b.points.compareTo(a.points);
    });
    _rows.map((s) {
      s.position = ++x;
      return s;
    }).toList();

    notifyListeners();
  }

  StandingsModel(List<Round> rounds){
    update(rounds);
  }
}

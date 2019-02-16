import 'package:championship/model/match.dart';
class Round{
  List<Match> _matches;

  List<Match> get matches => _matches;


  Round(this._matches);

  @override
  String toString() {
    return 'Round{_matches: $_matches}';
  }


}
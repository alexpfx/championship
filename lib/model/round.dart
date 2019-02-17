import 'package:championship/model/match_info.dart';
class Round{
  List<MatchInfo> _matches;

  List<MatchInfo> get matches => _matches;


  Round(this._matches);

  @override
  String toString() {
    return 'Round{_matches: $_matches}';
  }


}
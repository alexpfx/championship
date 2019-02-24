import 'package:championship/model/match_info.dart';
class Round{
  List<MatchInfo> _matches;

  List<MatchInfo> get matches => _matches;

  String _name;


  String get name => _name;

  Round(this._matches, this._name);

  @override
  String toString() {
    return 'Round{_matches: $_matches}';
  }


}
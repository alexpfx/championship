import 'package:parse_server_sdk/parse_server_sdk.dart';

class Team {
  String _teamName;
  double _teamPower;
  String _shieldImage;

  String get shieldImage => _shieldImage;

  Team(this._teamName, this._teamPower);

  double get teamPower => _teamPower;

  String get teamName => _teamName;


  @override
  String toString() {
    return 'Team{_teamName: $_teamName';
  }

  Team.fromObject(ParseObject obj) {
    _teamName = obj.get("name");
    _teamPower = (obj.get("power") as num).toDouble();
    _shieldImage = obj.get("teamShield");
  }
}

import 'package:championship/model/team.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TeamsModel extends Model {
  TeamsModel() {
    Parse().initialize(
      "x",
      "https://parseapi.back4app.com/",
      clientKey: "x",
    );

    loadTeams();
  }

  List<Team> _teams = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<Team> get teams => _teams;

  int get size => _teams.length;

  loadTeams() async {
    _teams.clear();

    _isLoading = true;
    var response = await ParseObject("BrasileiroTeams2019").getAll();



    if (response.success) {
      for (var value in response.result) {
        var obj = value as ParseObject;
        _teams.add(Team.fromObject(obj));
      }

    }
    _isLoading = false;
    notifyListeners();
  }
}

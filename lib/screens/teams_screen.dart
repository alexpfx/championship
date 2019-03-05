import 'package:championship/model/team.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/screens/rounds_screen.dart';
import 'package:flutter/material.dart';

class TeamsScreen extends StatefulWidget {
  TeamsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _inputTeamController = TextEditingController();
  var _teamList = <Team>[];
  final double _defaultHeightSpace = 8;
  double _attackPower = 70;

  var _formKey = GlobalKey<FormState>();

  TournamentSetup _setup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _inputTeamController,
                        validator: validateTeamName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                            hintText: "Team Name",
                            hintStyle: TextStyle(fontSize: 18),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              iconSize: 24,
                              onPressed: () {
                                _inputTeamController.clear();
                              },
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: _defaultHeightSpace,
                ),
                Slider(
                label: "team power: $_attackPower",
                  divisions: 10,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value){
                    setState(() {
                      _attackPower = value;
                    });
                  },

                  value: _attackPower,
                  min: 30,
                  max: 90
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                        onPressed: addTeam,
                        icon: Icon(Icons.done),
                        label: Text("Add Team")),
                  ],
                ),
                SizedBox(
                  height: _defaultHeightSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Number of teams: "),
                        Text(_teamList.length.toString()),
                      ],
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.input),
                      label: Text("Confirm"),
                      onPressed: () {
                        confirmTeams(context);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: _defaultHeightSpace,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: _teamList.length,
                        itemBuilder: _listViewTeamsBuilder))
              ],
            ),
          ),
        ));
  }

  String validateTeamName(String name) {
    print(_teamList);

    if (_teamList.map((team) => team.teamName).toList().contains(name)) {
      return "Team $name already added to list";
    }

    return name.length >= 3
        ? null
        : "Invalid Team Name. Should have more than 2 characters length";
  }

  Widget _teamTileItem(teamName, power, position) => ListTile(
        title: Text(teamName),
        dense: true,
        subtitle: Text('Team Power: $power'),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _teamList.removeAt(position);
              });
            }),
      );

  Widget _listViewTeamsBuilder(BuildContext context, int index) {
    var team = _teamList[index];

    return _teamTileItem(
        team.teamName, team.teamPower.toStringAsFixed(2), index);
  }

  void confirmTeams(BuildContext context) {
    if (_teamList.isEmpty) {
      _teamList = _fakeTeamList();
    }

    final minNrOfTeams = 4;
    if (_teamList.length < minNrOfTeams) {
      var snackBar = SnackBar(
          content: Text('Tournament must have more than $minNrOfTeams teams.'));

      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    _setup = TournamentSetup(
        TournamentRoundMode.single, TournamentType.league, _teamList);

    //TODO passar funcao callback e criar setup na hora.
    _showConfirmDialog();
  }

  void addTeam() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _teamList.insert(
            0,
            Team(
              _inputTeamController.text,
              _attackPower.truncateToDouble(),
            ));
        _attackPower = 70;
        _inputTeamController.clear();
      });
    }
  }

  void _showConfirmDialog() {
    showDialog(context: context, builder: _buildDialog);
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm tournament creation?"),
      actions: <Widget>[
        new FlatButton(
          child: new Text("No, back to previous screen"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new RaisedButton(
            child: Text("Yes"),
            onPressed: () {
//              Navigator.of(context).pushNamed("/rounds");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RoundsScreen.from(_setup),
              ));
            })
      ],
    );
  }

  List<Team> _fakeTeamList() {
    return [
      Team(
        "Grêmio",
        76,
      ),
      Team(
        "Internacional",
        79,
      ),
      Team(
        "Flamengo",
        82,
      ),
      Team(
        "Fluminense",
        55,
      ),
      Team(
        "Vasco",
        53,
      ),
      Team(
        "Botafogo",
        61,
      ),
      Team(
        "Palmeiras",
        90,
      ),
      Team(
        "São Paulo",
        73,
      ),
      Team(
        "Santos",
        60,
      ),
      Team(
        "Corinthians",
        54,
      ),
      Team(
        "Ceará",
        54,
      ),
      Team(
        "Bahia",
        58,
      ),
      Team(
        "Vitória",
        47,
      ),
      Team(
        "Chapecoense",
        45,
      ),
      Team(
        "Cruzeiro",
        63,
      ),
      Team(
        "Atlético Mineiro",
        69,
      ),
      Team(
        "América Mineiro",
        50,
      ),
      Team(
        "Atlético Paranaense",
        67,
      ),
      Team(
        "Paraná",
        33,
      ),
      Team(
        "Sport",
        52,
      ),
    ];
  }
}

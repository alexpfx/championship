import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/round_bloc.dart';
import 'package:championship/model/team.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/screens/rounds_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

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
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
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
                FluidSlider(
                  labelsTextStyle: TextStyle(fontSize: 12),
                  valueTextStyle: TextStyle(fontSize: 12),
                  value: double.parse(_attackPower.toString()),
                  min: 30,
                  max: 99,
                  onChanged: (newValue) {
                    print('changed');
                    setState(() {
                      this._attackPower = newValue;
                    });
                  },
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
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
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
        team.teamName, team.attackPower.toStringAsFixed(2), index);
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
            0, Team(_inputTeamController.text, _attackPower.truncateToDouble(), 70));
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
            textColor: Colors.white,
            onPressed: () {
//              Navigator.of(context).pushNamed("/rounds");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        bloc: TournamentBloc(),
                        child: RoundsScreen.from(_setup),
                      )));
            })
      ],
    );
  }

  List<Team> _fakeTeamList() {
    return [
      Team("Grêmio", 99, 70),
      Team("Internacional", 79, 70),
      Team("Flamengo", 90, 70),
      Team("Fluminense", 45, 70),
      Team("Vasco", 45, 70),
      Team("Botafogo", 45, 70),
      Team("Palmeiras", 95, 70),
      Team("São Paulo", 79, 70),
      Team("Santos", 45, 70),
      Team("Corinthians", 45, 70),
      Team("Ceará", 45, 70),
      Team("Bahia", 45, 70),
      Team("Vitória", 45, 70),
      Team("Chapecoense", 45, 70),
      Team("Cruzeiro", 45, 70),
      Team("Atlético Mineiro", 45, 70),
      Team("América Mineiro", 45, 70),
      Team("Atlético Paranaense", 45, 70),
      Team("Paraná", 45, 70),
      Team("Sport", 45, 70),
    ];
  }
}

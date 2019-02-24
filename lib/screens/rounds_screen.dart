import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/bloc/tournament_bloc.dart';
import 'package:championship/model/round.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/widgets/round_widget.dart';
import 'package:flutter/material.dart';

class RoundsScreen extends StatefulWidget {
  TournamentSetup setup;

  RoundsScreen.from(this.setup);

  @override
  _RoundsScreenState createState() => _RoundsScreenState();
}

class _RoundsScreenState extends State<RoundsScreen> {
  @override
  Widget build(BuildContext context) {
    var tournamentProvider = BlocProviderList.of<TournamentBloc>(context);

    tournamentProvider.inputTournamentSetup.add(widget.setup);

    return Scaffold(
      appBar: AppBar(
        title: Text("Rounds and Matches"),
        actions: <Widget>[
          IconButton(
            tooltip: "standings",
            onPressed: () {},
            icon: Icon(
              Icons.apps,
              color: Colors.white,
              semanticLabel: "Standings",
            ),
          ),
        ],
      ),
      body: BlocProviderList(
        listBloc: [Bloc(TournamentBloc()), Bloc(MatchSimulatorBloc())],
        child: StreamBuilder(
            stream: tournamentProvider.outRoundCreator, builder: _roundBuilder),
      ),
    );
  }

  Widget _roundBuilder(
      BuildContext context, AsyncSnapshot<List<Round>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return _itemBuilder(context, index, snapshot.data);
          });
    } else {
      return Center(child: Text("no data"));
    }
  }

  Widget _itemBuilder(BuildContext context, int index, List<Round> rounds) {
    Round r = rounds[index];
    return RoundWidget(r);
  }
}

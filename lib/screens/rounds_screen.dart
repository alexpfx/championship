import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/bloc/tournament_bloc.dart';
import 'package:championship/model/round.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/widgets/round_widget.dart';
import 'package:championship/widgets/standings_widget.dart';
import 'package:flutter/material.dart';

class RoundsScreen extends StatefulWidget {
  TournamentSetup setup;

  RoundsScreen.from(this.setup);

  @override
  _RoundsScreenState createState() => _RoundsScreenState();
}

class _RoundsScreenState extends State<RoundsScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Round> _rounds = [];

  @override
  Widget build(BuildContext context) {
    var tournamentProvider = BlocProviderList.of<TournamentBloc>(context);

    tournamentProvider.inputTournamentSetup.add(widget.setup);

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
//          _scaffoldKey.currentState.showBottomSheet(_buildStandingsBottomSheet);

          showModalBottomSheet(
              context: context, builder: _buildStandingsBottomSheet);

//          showModalBottomSheet(context: context, builder: _buildStandingsBottomSheet);
        },
        child: Icon(Icons.format_list_numbered),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Rounds and Matches"),
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
      _rounds = snapshot.data;
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return _itemBuilder(context, index, _rounds);
          });
    } else {
      return Center(child: Text("no data"));
    }
  }

  Widget _itemBuilder(BuildContext context, int index, List<Round> rounds) {
    Round r = rounds[index];
    return RoundWidget(r);
  }

  Widget _buildStandingsBottomSheet(BuildContext context) {
    return Container(
      child: StandingsWidget(_rounds),
    );
  }
}

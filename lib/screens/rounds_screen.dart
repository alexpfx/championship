import 'package:championship/model/round.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/smodel/tournament_model.dart';
import 'package:championship/widgets/round_widget.dart';
import 'package:championship/widgets/standings_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: _buildStandingsBottomSheet);
        },
        child: Icon(Icons.format_list_numbered, color: Colors.white,),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Rounds and Matches"),
      ),
      body: FutureBuilder(
          future: ScopedModel.of<TournamentModel>(context).build(widget.setup),
          builder: _roundBuilder),
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

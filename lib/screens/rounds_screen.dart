import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/round_bloc.dart';
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
    var provider = BlocProvider.of<TournamentBloc>(context);
    provider.inputTournamentSetup.add(widget.setup);

    return Scaffold(
      appBar: AppBar(
        title: Text("Rounds and Matches"),
        actions: <Widget>[
          IconButton(
            tooltip: "standings",
            onPressed: (){

            },
            icon: Icon(
              Icons.apps,
              color: Colors.white,
              semanticLabel: "Standings",
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: provider.outRoundCreator, builder: _roundBuilder),
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
    final defaultTextStyle =
        TextStyle(color: Colors.black54, fontWeight: FontWeight.w700);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2)),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Round ${index + 1}",
                  style: defaultTextStyle,
                ),
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow),
                      label: Text("Simulate", style: defaultTextStyle)))
            ],
          ),
          RoundWidget(r)
        ],
      ),
    );
  }
}

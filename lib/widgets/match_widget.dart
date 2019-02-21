import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MatchWidget extends StatelessWidget {
  final MatchInfo _matchInfo;

  MatchWidget(this._matchInfo);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MatchModel>(
      model: new MatchModel(_matchInfo),
      child: Card(
        child: ScopedModelDescendant<MatchModel>(
          builder: _buildModel,
        ),
      ),
    );
  }

  Widget _buildModel(BuildContext context, Widget child, MatchModel model) {
    const horizontalPadding = 16.0;
    const verticalPadding = 16.0;

    MatchInfo matchInfo = model.matchInfo;
    MatchEvent lastEvent = model.lastEvent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.black54),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(right: 16),
                  onPressed: () {
                    model.startSimulation(90);

//                    BlocProviderList.of<MatchSimulatorBloc>(context)
//                        .inMatchInfo
//                        .add(matchInfo);

                  },
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                Text(
                  matchInfo.info,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    matchInfo.homeTeam.teamName,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    lastEvent?.homeTeamScore?.toString() ?? "0",
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  matchInfo.awayTeam.teamName,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Text(
                  lastEvent?.awayTeamScore?.toString() ?? "0",
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

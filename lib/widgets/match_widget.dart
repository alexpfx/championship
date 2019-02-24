import 'package:championship/model/match_info.dart';
import 'package:championship/model/match_result.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:flutter/material.dart';

class MatchWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(child: _buildModel(context),);
  }

  Widget _buildModel(context) {
    const horizontalPadding = 16.0;
    const verticalPadding = 16.0;

    MatchModel model = MatchModel.of(context);

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    matchInfo.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
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

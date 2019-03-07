import 'package:championship/model/match_result.dart';
import 'package:championship/model/match_status.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:flutter/material.dart';

class MatchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: _buildModel(context),
    );
  }

  Widget _buildModel(context) {
    const horizontalPadding = 8.0;
    const verticalPadding = 16.0;

    MatchModel model = MatchModel.of(context);

    MatchEvent lastEvent = model.lastEvent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    model.matchName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "${model.time} \'",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _colorFromMatchStatus(model.status),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    model.status.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
                  flex: 4,
                  child: Text(
                    model.homeTeamName,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 1,
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
                flex: 4,
                child: Text(
                  model.awayTeamName,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 1,
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

  _colorFromMatchStatus(MatchStatus matchStatus) {
    switch (matchStatus) {
      case MatchStatus.notStarted:
        return Colors.grey[900];
      case MatchStatus.running:
        return Colors.green[900];
      case MatchStatus.ended:
        return Colors.blue[900];
    }
  }
}

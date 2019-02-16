import 'package:flutter/material.dart';

class MatchWidget extends StatefulWidget {
  const MatchWidget(this.matchName, this.homeTeam, this.awayTeam,
      this.homeScore, this.awayScore);

  @override
  _MatchWidgetState createState() => _MatchWidgetState();

  final String matchName;
  final String homeTeam;
  final String awayTeam;
  final String homeScore;
  final String awayScore;
}

class _MatchWidgetState extends State<MatchWidget> {
  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;
    const verticalPadding = 16.0;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black54),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.matchName,
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
                      widget.homeTeam,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.homeScore,
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
                    widget.awayTeam,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.awayScore,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

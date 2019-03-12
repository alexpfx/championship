import 'package:championship/model/standings_row.dart';
import 'package:flutter/material.dart';

class StandingsRowTile extends StatelessWidget {
  final StandingsRow _row;
  final bool _header;

  StandingsRowTile(this._row, this._header);

  TextStyle headerStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    const pad = 4.0;
    _buildTable();

    if (_header) {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                child: Text(
              'Pos #',
              style: headerStyle,
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Team',
                  style: headerStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'MP',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'W',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'D',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'L',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'GF',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'GA',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'GD',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                'PTs',
                style: headerStyle,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                _row.position.toString(),
                style: headerStyle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _row.team,
                  style: headerStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.matchPlayed.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.wins.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.draws.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.loses.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.goalsFor.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.goalsAgainst.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.goalsDifference.toString(),
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(pad),
              child: Text(
                _row.points.toString(),
                style: headerStyle,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTable() {
    return Table(children: [
      TableRow(children: [_buildHeader()]),
    ]);
  }

  _buildHeader() {}
}

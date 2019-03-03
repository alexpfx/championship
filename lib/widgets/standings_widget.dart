import 'package:championship/model/round.dart';
import 'package:championship/model/standings_row.dart';
import 'package:championship/smodel/standings_model.dart';
import 'package:championship/tiles/standings_row_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StandingsWidget extends StatelessWidget {
  final List<Round> _rounds;
  BuildContext context;

  StandingsWidget(this._rounds);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ScopedModel(
      model: StandingsModel(_rounds),
      child: ScopedModelDescendant<StandingsModel>(builder: _buildModel),
    );
  }

  TextStyle headerStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);

  Widget _buildModel(BuildContext context, Widget child, StandingsModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: _buildTable(model, context)),
    );
  }

  _buildTable(StandingsModel model, BuildContext context) {
    return Table(
      defaultColumnWidth: FixedColumnWidth(40),
      columnWidths: {1: FixedColumnWidth(120)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.black12, width: 1),
      ),
      children: _buildTableRows(model),
    );
  }

  List<TableRow> _buildTableRows(StandingsModel model) {
    return [
      TableRow(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue, Colors.blueAccent])),
          children: [
            _cellt("", textStyle: headerStyle),
            _cellt("Team", textStyle: headerStyle),
            _cellt("Pts", textStyle: headerStyle),
            _cellt("MP", textStyle: headerStyle),
            _cellt("W", textStyle: headerStyle),
            _cellt("D", textStyle: headerStyle),
            _cellt("L", textStyle: headerStyle),
            _cellt("GF", textStyle: headerStyle),
            _cellt("GA", textStyle: headerStyle),
            _cellt("GD", textStyle: headerStyle),
          ]),
    ]..addAll(_buildDataRows(model));
  }

  List<TableRow> _buildDataRows(StandingsModel model) {
    print('model: ${model.rows.length}');

    return model.rows
        .map((s) => TableRow(children: [
              _cellt(s.position),
              _cellt(s.team, textStyle: boldStyle),
              _cellt(s.points, textStyle: boldStyle),
              _cellt(s.matchPlayed),
              _cellt(s.wins),
              _cellt(s.draws),
              _cellt(s.loses),
              _cellt(s.goalsFor),
              _cellt(s.goalsAgainst),
              _cellt(s.goalsDifference),
            ]))
        .toList();
  }

  _cellt(dynamic value,
      {TextStyle textStyle = const TextStyle(fontWeight: FontWeight.normal)}) {

    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        value is String? value: value.toString(),
        style: textStyle,
      ),
    );
  }

//  Widget _buildStandingTable(BuildContext context, int index) {
//    return index == 0? StandingsRowTile(null, index == 0): StandingsRowTile(StandingsRow('Gremio'), index == 0);
//
//  }
}

import 'package:championship/model/round.dart';
import 'package:championship/model/standings_row.dart';
import 'package:championship/smodel/standings_model.dart';
import 'package:championship/tiles/standings_row_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StandingsWidget extends StatelessWidget {
  final List<Round> _rounds;

  StandingsWidget(this._rounds);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: StandingsModel(_rounds),
      child: ScopedModelDescendant<StandingsModel>(builder: _buildModel),
    );
  }

  TextStyle headerStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  Widget _buildModel(BuildContext context, Widget child, StandingsModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: _buildTable(model, context)),
    );
//    return ListView(
//      children: List.generate(10, (index) => index).map((f){
//        return StandingsRowTile(StandingsRow("Grêmio"));
//      }).toList(),
//    );
  }

  _buildTable(StandingsModel model, BuildContext context) {
    return Table(
      defaultColumnWidth: FixedColumnWidth(45),
      columnWidths: {1: FixedColumnWidth(200)},
      border: TableBorder.symmetric(
        inside: BorderSide(color: Theme.of(context).accentColor, width: 1),
      ),
      children: _buildTableRows(model),
    );
  }

  List<TableRow> _buildTableRows(StandingsModel model) {
    return [
      TableRow(decoration: BoxDecoration(), children: [
        _rowHeader(""),
        _rowHeader("Team", false),
        _rowHeader("MP"),
        _rowHeader("W"),
        _rowHeader("D"),
        _rowHeader("L"),
        _rowHeader("GF"),
        _rowHeader("GA"),
        _rowHeader("GD"),
        _rowHeader("Pts"),
      ]),
    ]..addAll(_buildDataRows(model));
  }

  List<TableRow> _buildDataRows(StandingsModel model) {
    print('model: ${model.rows.length}');

    return model.rows
        .map((s) => TableRow(children: [
              _celln(s.position),
              _cellt(s.team, false),
              _celln(s.matchPlayed),
              _celln(s.wins),
              _celln(s.draws),
              _celln(s.loses),
              _celln(s.goalsFor),
              _celln(s.goalsAgainst),
              _celln(s.goalsDifference),
              _celln(s.points),
            ]))
        .toList();
  }

  _rowHeader(String text, [centered = true]) {
    return centered
        ? Center(child: Text(text))
        : Padding(
            padding: EdgeInsets.all(8),
            child: Text(text),
          );
  }

  _celln(int number, [bool centered = true]) {
    return this._cellt(number.toString(), centered);
  }

  _cellt(String text, [bool centered = true]) {
    return TableCell(
      child: centered
          ? Center(child: Text(text))
          : Padding(
              padding: EdgeInsets.all(8),
              child: Text(text),
            ),
    );
  }

//  Widget _buildStandingTable(BuildContext context, int index) {
//    return index == 0? StandingsRowTile(null, index == 0): StandingsRowTile(StandingsRow('Gremio'), index == 0);
//
//  }
}

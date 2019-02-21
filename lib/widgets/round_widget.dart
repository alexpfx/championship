import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/model/round.dart';
import 'package:championship/widgets/match_widget.dart';
import 'package:flutter/material.dart';
import 'package:championship/model/match_info.dart';

class RoundWidget extends StatelessWidget {
  final Round _round;

  RoundWidget(this._round);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: _round.matches.length,
          itemBuilder: _buildListView),
    );
  }

  Widget _buildListView(BuildContext context, int index) {

    MatchInfo match = _round.matches[index];
    match.info = "Match ${index + 1} of ${_round.matches.length}";
    return AspectRatio(
      aspectRatio: 1.4,
      child: MatchWidget(match),
    );
  }
}

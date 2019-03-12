import 'package:championship/model/team.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:math';

class TeamTile extends StatelessWidget {
  final TeamViewModel teamViewModel;

  TeamTile(this.teamViewModel);

  Random r = Random();

  @override
  Widget build(BuildContext context) {
    var team = teamViewModel.team;
    print('team: ${team.teamName}');
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(width: 1))),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 0.8,
              child: (extension(team.shieldImage) != ".svg")
                  ? Image.network(
                      team.shieldImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.scaleDown,
                      filterQuality: FilterQuality.high,
                    )
                  : SvgPicture.network(
                      team.shieldImage,
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 60,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(team.teamName),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(team.teamPower.toStringAsFixed(1)),
          )
        ],
      ),
    );
  }
}

class TeamViewModel {
  final Team team;
  final int position;

  TeamViewModel(this.team, this.position);
}

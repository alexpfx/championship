import 'package:championship/model/round.dart';
import 'package:championship/model/round_status.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:championship/smodel/round_model.dart';
import 'package:championship/widgets/match_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RoundWidget extends StatelessWidget {
  RoundModel _roundModel;

  var defaultTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

  RoundWidget(Round _round) {
    _roundModel = RoundModel(_round);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<RoundModel>(
        model: _roundModel,
        child: ScopedModelDescendant<RoundModel>(builder: _buildRoundWidget));
  }

  Widget _buildListView(BuildContext context, int index) {
    var match = _roundModel.matchAt(index);
    return ScopedModel<MatchModel>(
      model: match,
      child: ScopedModelDescendant<MatchModel>(
        builder: (BuildContext context, Widget child, Model model) {
          return AspectRatio(
            aspectRatio: 1.4,
            child: MatchWidget(),
          );
        },
      ),
    );
  }

  Widget _buildRoundWidget(
      BuildContext context, Widget child, RoundModel model) {
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
                  model.name,
                  style: defaultTextStyle,
                ),
              ),
              Container(
                child: Text(
                  model.roundStatus.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _colorFromMatchStatus(model.roundStatus)),
                ),
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: FlatButton.icon(
                      onPressed: () {
                        model.runTheGame();
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text("Start", style: defaultTextStyle)))
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: model.numberOfMatches,
                itemBuilder: _buildListView),
          )
        ],
      ),
    );
  }

  _colorFromMatchStatus(RoundStatus roundStatus) {
    switch (roundStatus) {
      case RoundStatus.notStarted:
        return Colors.red;
      case RoundStatus.started:
        return Colors.green;
      case RoundStatus.ended:
        return Colors.blue;
    }
  }
}

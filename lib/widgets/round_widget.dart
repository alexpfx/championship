import 'package:championship/model/match_info.dart';
import 'package:championship/model/round.dart';
import 'package:championship/smodel/match_model.dart';
import 'package:championship/smodel/round_model.dart';
import 'package:championship/widgets/match_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RoundWidget extends StatelessWidget {
  RoundModel _roundModel;

  var defaultTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18);

  RoundWidget(Round _round) {
    _roundModel = RoundModel(_round);
  }

  @override
  Widget build(BuildContext context) {
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
                  _roundModel.name,
                  style: defaultTextStyle,
                ),
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: FlatButton.icon(
                      onPressed: () {
                        _roundModel.runTheGame();
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text("Simulate", style: defaultTextStyle)))
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _roundModel.numberOfMatches,
                itemBuilder: _buildListView),
          )
        ],
      ),
    );
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
}

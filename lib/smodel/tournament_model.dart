import 'package:championship/model/round.dart';
import 'package:championship/model/tournament_setup.dart';
import 'package:championship/tournament_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class TournamentModel extends Model {
  List<Round> _rounds;

  static TournamentModel of (context){
      return ScopedModel.of<TournamentModel>(context);
  }

  TournamentModel();

  Future<List<Round>> build(setup) async{
    notifyListeners();
    _rounds = buildTournament(setup);
    return _rounds;
  }

  List<Round> get rounds => _rounds;

}

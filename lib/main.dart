import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/bloc/tournament_bloc.dart';
import 'package:championship/screens/teams_screen.dart';
import 'package:championship/smodel/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'colors.dart';

void main() => runApp(MyApp());

ThemeData buildThemeData() {
  var baseTheme = ThemeData.dark();

  return baseTheme.copyWith(


  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderList(
      listBloc: [Bloc(TournamentBloc()), Bloc(MatchSimulatorBloc())],
      child: ScopedModel<TournamentModel>(
        model: TournamentModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => TeamsScreen(
                    title: "Add Teams",
                  ),
            },
            title: 'Flutter Demo',
            theme: buildThemeData()),
      ),
    );
  }
}

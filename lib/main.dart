import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:championship/bloc/match_simulator_bloc.dart';
import 'package:championship/bloc/tournament_bloc.dart';
import 'package:championship/screens/teams_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderList(
      listBloc: [Bloc(TournamentBloc()), Bloc(MatchSimulatorBloc())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => TeamsScreen(
                  title: "Add Teams",
                ),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            // Define the default Brightness and Colors
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600],

            // Define the default Font Family
            fontFamily: 'Montserrat',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frappe_app/src/pages/coffee_bloc.dart';

import 'coffee_conceps_home.dart';

class MainFrappePage extends StatefulWidget {
  @override
  _MainFrappePageState createState() => _MainFrappePageState();
}

class _MainFrappePageState extends State<MainFrappePage> {
  final bloc = CoffeeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: CoffeeProvider(
            bloc: bloc,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CoffeConcepHome(),
            )));
  }
}

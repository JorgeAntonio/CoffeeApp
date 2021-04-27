import 'package:flutter/material.dart';

import 'coffee_conceps_home.dart';

class MainFrappePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData.light(), child: CoffeConcepHome());
  }
}

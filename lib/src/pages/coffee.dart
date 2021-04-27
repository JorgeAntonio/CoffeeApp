import 'dart:math';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final randon = Random();
final coffees = List.generate(
  _names.length,
  (index) => Coffe(
    image: 'images/${index + 1}.png',
    name: _names[index],
    price: _doubleInRange(randon, 3, 7),
  ),
);

class Coffe {
  Coffe({
    @required this.name,
    @required this.image,
    @required this.price,
  });
  final String name;
  final String image;
  final double price;
}

final _names = [
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffe Nut Latte',
  'Capuchino',
  'Toffe Nut Iced Latte',
  'Americano',
  'Caramel Macchiato',
  'Vietnamese-Style Iced Coffe',
  'Black Tea Latte',
  'Classic Irish Coffe',
  'Toffe Nut Crunch Latte',
];

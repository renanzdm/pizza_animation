import 'package:flutter/cupertino.dart';

class IngredientModel {
  final String image;
  final List<Offset> offsets;

  const IngredientModel(this.image, this.offsets);

  bool compare(IngredientModel model) => model.image == image;
}

final ingredients = const <IngredientModel>[
  IngredientModel('assets/img/chili.png', <Offset>[
    Offset(0.1, 0.2),
    Offset(0.2, 0.4),
    Offset(0.6, 0.7),
    Offset(0.8, 0.3),
    Offset(0.34, 0.1),
  ]),
  IngredientModel('assets/img/garlic.png', <Offset>[
    Offset(0.5, 0.2),
    Offset(0.1, 0.3),
    Offset(0.6, 0.8),
    Offset(0.43, 0.1),
    Offset(0.3, 0.6),
  ]),
  IngredientModel('assets/img/olive.png', <Offset>[
    Offset(0.5, 0.2),
    Offset(0.1, 0.3),
    Offset(0.6, 0.8),
    Offset(0.43, 0.1),
    Offset(0.1, 0.3),
  ]),
  IngredientModel('assets/img/onion.png', <Offset>[
    Offset(0.2, 0.5),
    Offset(0.4, 0.1),
    Offset(0.6, 0.2),
    Offset(0.7, 0.7),
    Offset(0.2, 0.23),
  ]),
  IngredientModel('assets/img/pea.png', <Offset>[
    Offset(0.5, 0.2),
    Offset(0.1, 0.3),
    Offset(0.62, 0.5),
    Offset(0.43, 0.5),
    Offset(0.5, 0.2),
  ]),
  IngredientModel('assets/img/pickle.png', <Offset>[
    Offset(0.5, 0.2),
    Offset(0.1, 0.3),
    Offset(0.6, 0.4),
    Offset(0.3, 0.5),
    Offset(0.2, 0.4),
  ]),
  IngredientModel('assets/img/potato.png', <Offset>[
    Offset(0.5, 0.2),
    Offset(0.1, 0.3),
    Offset(0.3, 0.7),
    Offset(0.43, 0.1),
    Offset(0.6, 0.7),
  ]),
];

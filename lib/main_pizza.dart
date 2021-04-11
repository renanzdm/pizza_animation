import 'package:flutter/material.dart';
import 'package:pizza_order_animation/pizza_ingredient_model.dart';

class PizzaOrderDetails extends StatefulWidget {
  @override
  _PizzaOrderDetailsState createState() => _PizzaOrderDetailsState();
}

const _pizzaCartSize = 48.0;

class _PizzaOrderDetailsState extends State<PizzaOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'New Orleans Pizza',
          style: TextStyle(fontSize: 22, color: Colors.grey.shade700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart_outlined,
                color: Colors.grey.shade700),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _PizzaDetails(),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 2,
                    child: _PizzaIngredients(),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: _PizzaCartButton(),
          )
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  var _listIngredients = <IngredientModel>[];
  int _total = 15;
  final _notifierFoused = ValueNotifier(false);
  List<Animation> _animationList = <Animation>[];
  BoxConstraints _pizzaConstraints;

  Widget _buildIngredients() {
    List<Widget> elements = [];
    if (_animationList.isNotEmpty) {
      for (var i = 0; i < _listIngredients.length; i++) {
        IngredientModel ingredient = _listIngredients[i];
        for (var j = 0; j < ingredient.offsets.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.offsets[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0, fromY = 0.0;
          if (i == _listIngredients.length - 1) {
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxWidth * (1 - animation.value);
            }
            final opacity = animation.value;
            if (animation.value > 0) {
              elements.add(Opacity(
                opacity: opacity,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      fromX + _pizzaConstraints.maxWidth * positionX,
                      fromY + _pizzaConstraints.maxHeight * positionY,
                    ),
                  child: Image.asset(
                    ingredient.image,
                    height: 40,
                  ),
                ),
              ));
            }
          } else {
            elements.add(Transform(
              transform: Matrix4.identity()
                ..translate(
                  _pizzaConstraints.maxWidth * positionX,
                  _pizzaConstraints.maxHeight * positionY,
                ),
              child: Image.asset(
                ingredient.image,
                height: 40,
              ),
            ));
          }
        }
      }
      return Stack(children: elements);
    }
    return SizedBox.shrink();
  }

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.7, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.9, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.9, curve: Curves.decelerate),
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<IngredientModel>(
                onAccept: (ingredient) {
                  print('onAccept');

                  _notifierFoused.value = false;
                  setState(() {
                    _total++;
                    _listIngredients.add(ingredient);
                  });
                  _buildIngredientsAnimation();
                  _animationController.forward(from: 0.0);
                },
                onWillAccept: (ingredient) {
                  print('onWillAccept');

                  _notifierFoused.value = true;

                  for (var item in _listIngredients) {
                    if (item.compare(ingredient)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (ingredient) {
                  _notifierFoused.value = false;

                  print('onLeave');
                },
                builder: (context, list, reject) {
                  return LayoutBuilder(builder: (context, constraints) {
                    _pizzaConstraints = constraints;
                    return Center(
                      child: ValueListenableBuilder<bool>(
                          valueListenable: _notifierFoused,
                          builder: (context, value, _) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: value
                                  ? constraints.maxHeight
                                  : constraints.maxHeight - 10,
                              child: Stack(
                                children: [
                                  Image.asset('assets/img/dish.png'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                        Image.asset('assets/img/pizza-1.png'),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                '\$$_total',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                key: UniqueKey(),
              ),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                          begin: Offset(0.0, 0.0),
                          end: Offset(0.0, animation.value)),
                    ),
                    child: child,
                  ),
                );
              },
            ),
          ],
        ),
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return _buildIngredients();
            }),
      ],
    );
  }
}

class _PizzaCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.orange.withOpacity(0.5), Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
      ),
    );
  }
}

class _PizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingredients.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final ingredient = ingredients[index];
          return _ItemIngredients(ingredient: ingredient);
        });
  }
}

class _ItemIngredients extends StatelessWidget {
  final IngredientModel ingredient;

  const _ItemIngredients({Key key, this.ingredient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final child = Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(4),
      height: 45,
      width: 45,
      child: Image.asset(ingredient.image),
      decoration: BoxDecoration(
        color: Color(0xFFF5EED3),
        shape: BoxShape.circle,
      ),
    );

    return Center(
      child: Draggable(
        feedback: DecoratedBox(
          child: child,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 10.0),
                blurRadius: 3,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        data: ingredient,
        child: child,
      ),
    );
  }
}

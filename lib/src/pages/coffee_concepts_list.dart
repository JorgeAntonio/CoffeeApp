import 'package:flutter/material.dart';
import 'package:frappe_app/src/pages/coffee.dart';
import 'package:frappe_app/src/pages/coffee_concept_details.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class FrappeConcepsList extends StatefulWidget {
  const FrappeConcepsList({Key key}) : super(key: key);

  @override
  _FrappeConcepsListState createState() => _FrappeConcepsListState();
}

class _FrappeConcepsListState extends State<FrappeConcepsList> {
  final _pageCoffeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final _pageTextController = PageController(initialPage: _initialPage.toInt());

  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeSrollListener() {
    setState(() {
      _currentPage = _pageCoffeController.page;
    });
  }

  void _textScrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeController.addListener(_coffeSrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeController.removeListener(_coffeSrollListener);
    _pageTextController.removeListener(_textScrollListener);
    _pageCoffeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.22,
              height: size.height * 0.3,
              child: DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45,
                )
              ])),
            ),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                  controller: _pageCoffeController,
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length + 1,
                  onPageChanged: (value) {
                    if (value < coffees.length) {
                      _pageTextController.animateToPage(
                        value,
                        duration: _duration,
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }
                    final coffe = coffees[index - 1];
                    final result = _currentPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);
                    print(result);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 650),
                              pageBuilder: (context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: CoffeConceptDetails(coffee: coffe),
                                );
                              }),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                              0.0,
                              size.height / 2.6 * (1 - value).abs(),
                            )
                            ..scale(value),
                          child: Opacity(
                              opacity: opacity,
                              child: Hero(
                                tag: coffe.name,
                                child: Image.asset(
                                  coffe.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              )),
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, -150 * value),
                    child: child,
                  );
                },
                duration: _duration,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          itemCount: coffees.length,
                          controller: _pageTextController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final opacity =
                                (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                            return Opacity(
                              opacity: opacity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.2),
                                child: Hero(
                                  tag: "text_${coffees[index].name}",
                                  child: Material(
                                    child: Text(
                                      coffees[index].name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 15),
                    AnimatedSwitcher(
                      duration: _duration,
                      child: Text(
                        '\$${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24),
                        key: Key(coffees[_currentPage.toInt()].name),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

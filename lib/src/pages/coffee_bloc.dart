import 'package:flutter/cupertino.dart';

const _initialPage = 8.0;

class CoffeeBloc {
  final pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final pageTextController = PageController(initialPage: _initialPage.toInt());
  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void init() {
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageCoffeeController.addListener(_coffeSrollListener);
    pageTextController.addListener(_textScrollListener);
  }

  void _coffeSrollListener() {
    currentPage.value = pageCoffeeController.page;
  }

  void _textScrollListener() {
    textPage.value = pageTextController.page;
  }

  void dispose() {
    pageCoffeeController.removeListener(_coffeSrollListener);
    pageTextController.removeListener(_textScrollListener);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBloc bloc;

  CoffeeProvider({@required this.bloc, Widget child}) : super(child: child);

  static CoffeeProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

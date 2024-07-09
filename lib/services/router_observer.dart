import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_name_constants.dart';


class RouterObserver extends NavigatorObserver {
  static final List<String> _routeStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route.settings.name ?? '');
    // logger.i('Push Page -> ${route.settings.name}');
  }

  static bool popUntil(BuildContext context, List<String> routeName) {
    for (var route in routeName) {
      if (!_routeStack.contains(route)) return false;
    }

    while (!routeName.contains(_routeStack.last)) {
      GoRouter.of(context).pop();
    }
    return true;
  }

  static bool get isFirstRoute =>
      _routeStack.isEmpty || _routeStack.length == 1;

  static bool get isDashboard =>
      (_routeStack.isNotEmpty) &&
          _routeStack.last == RouteNameConstants.dashboardSRN;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.removeLast();
    // logger.i('Pop Page -> ${route.settings.name}');
  }
}

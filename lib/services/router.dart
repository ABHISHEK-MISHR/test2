
import 'package:go_router/go_router.dart';
import 'package:test2/constants/route_name_constants.dart';
import 'package:test2/screen/first_screen.dart';
import 'package:test2/screen/home_screen.dart';
import 'package:test2/services/router_observer.dart';

GoRouter routeConfigFromGoRouter = GoRouter(
  initialLocation: RouteNameConstants.landingConfigureSR,
  overridePlatformDefaultLocation: true,
  observers: [
    RouterObserver(),
  ],
  routes: [
    GoRoute(
      path: RouteNameConstants.landingConfigureSR,
      builder: (context, state) => FirstScreen(),
      name: RouteNameConstants.landingConfigureSRN,
    ),
    GoRoute(
      path: RouteNameConstants.homeSR,
      builder: (context, state) => HomeScreen(),
      name: RouteNameConstants.homeSRN,
    ),

  ],
);

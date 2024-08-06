
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test2/constants/route_name_constants.dart';
import 'package:test2/provider/test_provider.dart';
import 'package:test2/repo/repository.dart';
import 'package:test2/screen/bmi_screen/bmi%20_main_screen.dart';
import 'package:test2/screen/first_screen.dart';
import 'package:test2/screen/home_screen.dart';
import 'package:test2/services/router_observer.dart';

import '../screen/bmi_screen/dashboard_screen/dashboard_main_screen.dart';
import 'api.service.dart';

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
    GoRoute(
      path: RouteNameConstants.dashboardSR,
      builder: (context, state) => BottomBarBubbleExample(),
      name: RouteNameConstants.dashBoardSRN,
    ),

    GoRoute(
      path: RouteNameConstants.bmiSR,
      builder: (context, state) => ChangeNotifierProvider(
          create: (context) => TestProvider(
            testRepository: TestRepository( apiClient: context.read<ApiClient>(),)
          ),
          child: BmiMainScreen()),
      name: RouteNameConstants.bmiSRN,
    )
  ],
);

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test2/provider/global_provider.dart';
import 'package:test2/services/api.service.dart';
import 'package:test2/services/api_client.dart';
import 'package:test2/services/router.dart';
import 'package:test2/services/snackbar_helper.dart';
import 'package:test2/utils/hive_box_helper.dart';
import 'package:test2/utils/should_update_ui_helper.dart';

bool setupComplete = false;

void runMain() async {
  runZonedGuarded(() async {
    initialSetup();
    final router = routeConfigFromGoRouter;
    final apiClient = ApiClient();
    // final authProvider = AuthProvider(
    //     authRepo: AuthRepo(apiClient: apiClient),
    //     userRepo: UserRepo(apiClient: apiClient),
    //     easyfoneRegistrationRepo: EasyfoneRegistrationRepo(apiClient: apiClient)
    // );
    apiClient.initHttpClient(ApiHttpClient(
        // authProvider
        ));

    final globalStore = GlobalStore(
      // authProvider: authProvider,
      navigatorKey: router.routerDelegate.navigatorKey,
      // configRepo: ConfigRepo(apiClient: apiClient),
    );


    // authProvider.populateGlobalStore(globalStore);
    SnackBarHelper.instance.init(globalStore);

    runApp(CTMainApp(
      // syncProvider: syncProvider,
      globalStore: globalStore,
      // deviceProvider: deviceProvider,
      routeConfig: router,
      apiClient: apiClient,
      // authProvider: authProvider,
    ));

  }, (error, stack) {});
}

Future<void> initialSetup() async {
  if (!setupComplete) {
    setupComplete = true;
    WidgetsFlutterBinding.ensureInitialized();
    await HiveBoxHelper.instance.init();
  }
}



class CTMainApp extends StatelessWidget {
  const CTMainApp(
      {super.key,
        required this.globalStore,
        required this.routeConfig,
        // required this.deviceProvider,
        // required this.syncProvider,
        required this.apiClient,
        // required this.authProvider
      });
  final GlobalStore globalStore;
  // final AuthProvider authProvider;
  // final SyncProvider syncProvider;
  // final EasyfoneRegisteredDeviceProvider deviceProvider;
  final GoRouter routeConfig;
  final ApiClient apiClient;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: globalStore),
        ChangeNotifierProvider.value(value: apiClient),
        // ChangeNotifierProvider.value(value: authProvider),
        // ChangeNotifierProvider.value(value: syncProvider),
        // ChangeNotifierProvider.value(value: deviceProvider),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling, alwaysUse24HourFormat: false),
            child: Stack(
              children: [
                child ?? Container(),
                if (Platform.isIOS)
                  KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        final visible = isKeyboardVisible && keyboardHeight > 0;
                        if (!visible) {
                          return const SizedBox();
                        }
                        return Positioned(
                          bottom: keyboardHeight,
                          left: 0,
                          right: 0,
                          child: ValueListenableBuilder(
                              valueListenable:
                              ShouldUpdateUIHelper.updateKeyboardType,
                              builder: (context, k, _) {
                                if (k != TextInputType.number &&
                                    k != TextInputType.phone) {
                                  return const SizedBox();
                                }
                                return Container(
                                  height: 40,
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.only(
                                      bottom:
                                      MediaQuery.of(context).padding.bottom),
                                  child: SafeArea(
                                    top: false,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            "Done",
                                          ),
                                          onPressed: () {
                                            Focus.of(context).unfocus();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
              ],
            ),
          );
        },
        title: 'Caretouch',
        routerConfig: routeConfig,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          dialogBackgroundColor: Colors.white,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
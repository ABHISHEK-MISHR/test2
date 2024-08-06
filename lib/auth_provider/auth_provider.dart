import 'dart:async';
import 'package:test2/constants/log_utils.dart';
import 'package:test2/provider/base_provider.dart';

import '../auth_repo/auth_repo.dart';

class AuthProvider extends BaseChangeNotifierProvider {
  final AuthRepo _authRepo;
  // final UserRepo _userRepo;



  AuthRepo get authRepo => _authRepo;

  String? enteredOtp;
  // SwAuthResponse? _swAuthResponse;
  // Completer<bool> initialAuthCompleter = Completer();

  // SwUserModel? get currentUser => _swAuthResponse?.user;
  bool smsSignatureSentToCrashalytics = false;

  AuthProvider({required AuthRepo authRepo,
    // required UserRepo userRepo
  }) : _authRepo = authRepo;
        // _userRepo = userRepo;

  Future<void> logOut() async {
    setBusyForObject(logOut, true);
    try {
      final success = await _authRepo.getOtp();
      if (success != null) {
        enteredOtp =  success.toString();
      }
    } catch (e) {
      logger.e('Error while getting otp', error: e);
    }
    setBusyForObject(logOut, false);
  }




}
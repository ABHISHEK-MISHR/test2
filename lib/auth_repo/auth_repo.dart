import 'package:test2/constants/NetworkConstants.dart';
import 'package:test2/constants/common_utils.dart';
import 'package:test2/constants/log_utils.dart';
import 'package:test2/services/api.service.dart';
import 'package:test2/utils/enum_utils.dart';

class AuthRepo {
  final ApiClient apiClient;

  AuthRepo({required this.apiClient});
  Future<String?> getOtp() async {
    try {
      final res = await apiClient.request(
        path: NetworkConstants.health,
        type: RequestType.get,
      );
      if(validStatusCode.contains(res.statusCode))
      return res.data;
    } catch (e) {
      logger.e('Error in get otp api', error: e);
    }
    return "";
  }

  // Future<SwAuthResponse?> createUser(Map<String, dynamic> body) async {
  //   try {
  //     final res = await apiClient.request(
  //         path: NetworkConstants.createOrUpdateOrGetUser,
  //         type: RequestType.post,
  //         data: body,
  //         queryParameters: {
  //           'autoLogin': true,
  //         });
  //     if (validStatusCode.contains(res.statusCode) && res.data != null) {
  //       return SwAuthResponse.fromJson(res.data['data']);
  //     }
  //     return null;
  //   } catch (e) {
  //     logger.e('Error in get otp api', error: e);
  //   }
  //   return null;
  // }
  //
  // Future<void> getUser(
  //     {ResponseHandler<SwUserModel>? handler, String? navigationUserId}) async {
  //   try {
  //     final userId = navigationUserId ?? HiveBoxHelper.instance.getUserId();
  //     if (userId == null) {
  //       return;
  //     }
  //     final res = await apiClient.request(
  //       path: '${NetworkConstants.createOrUpdateOrGetUser}/$userId',
  //       type: RequestType.get,
  //       queryParameters: navigationUserId != null
  //           ? {
  //         QueryParamConstants.additionalProfileQP: true,
  //         QueryParamConstants.fetchFieldAccessQP: true,
  //       }
  //           : null,
  //     );
  //     if (validStatusCode.contains(res.statusCode) && res.data != null) {
  //       await handler?.onSuccess?.call(SwUserModel.fromJson(res.data!['data']));
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logger.e('Error in get otp api', error: e);
  //   }
  // }
  //
  // Future<void> getUserAcademics(
  //     {String? navigatingUserId,
  //       ResponseHandler<List<UserAcademiesModel>>? handler}) async {
  //   try {
  //     final userId = navigatingUserId ?? HiveBoxHelper.instance.getUserId();
  //     if (userId == null) {
  //       return;
  //     }
  //     final res = await apiClient.request(
  //       path: NetworkConstants.getOrUpdateuserAcademy(userId),
  //       type: RequestType.get,
  //     );
  //     if (validStatusCode.contains(res.statusCode) &&
  //         res.data != null &&
  //         res.data['data'] is List) {
  //       await handler?.onSuccess?.call((res.data['data'] as List)
  //           .map((e) => UserAcademiesModel.fromJson(e))
  //           .toList());
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logger.e('Error in get user education api', error: e);
  //   }
  // }
  //
  // Future<void> getUserAccessField(
  //     {ResponseHandler<UserFieldAccessModel>? handler,
  //       String? navigatingUserId}) async {
  //   try {
  //     final userId = navigatingUserId ?? HiveBoxHelper.instance.getUserId();
  //     if (userId == null) {
  //       return;
  //     }
  //     final res = await apiClient.request(
  //       path: NetworkConstants.getUserFieldAccess(userId),
  //       type: RequestType.get,
  //     );
  //     if (validStatusCode.contains(res.statusCode) && res.data != null) {
  //       await handler?.onSuccess
  //           ?.call(UserFieldAccessModel.fromJson(res.data!['data']));
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logger.e('Error in fetching user field access api', error: e);
  //   }
  // }
  //
  // Future<void> getUserWorkHistory(
  //     {ResponseHandler<List<UserWorkModel>>? handler,
  //       String? navigatingUserId}) async {
  //   try {
  //     final userId = navigatingUserId ?? HiveBoxHelper.instance.getUserId();
  //     if (userId == null) {
  //       return;
  //     }
  //     final res = await apiClient.request(
  //       path: NetworkConstants.getOrUpdateuserWork(userId),
  //       type: RequestType.get,
  //     );
  //     if (validStatusCode.contains(res.statusCode) &&
  //         res.data != null &&
  //         res.data['data'] is List) {
  //       await handler?.onSuccess?.call((res.data['data'] as List)
  //           .map((e) => UserWorkModel.fromJson(e))
  //           .toList());
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logger.e('Error in get user work history api', error: e);
  //   }
  // }
  //
  // Future<bool> logOut() async {
  //   return true;
  // }
  //
  // Future<void> verifyOtp(Map<String, dynamic> body,
  //     {ResponseHandler<SwAuthResponse>? handler}) async {
  //   try {
  //     final res = await apiClient.request(
  //       path: NetworkConstants.authorizePath,
  //       type: RequestType.post,
  //       data: body,
  //     );
  //     if (res.statusCode == 200 && res.data != null) {
  //       await handler?.onSuccess
  //           ?.call(SwAuthResponse.fromJson(res.data!['data']));
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logger.e('Error in get otp api', error: e);
  //     await handler?.getErrorHandler(500)?.call();
  //   }
  // }
  //
  // Future<void> refreshToken(
  //     {required String refreshToken,
  //       ResponseHandler<SwAuthModel>? handler}) async {
  //   try {
  //     final res = await apiClient.request(
  //       path: NetworkConstants.refreshToken,
  //       ignoreRefreshController: true,
  //       type: RequestType.post,
  //       data: {"refreshToken": refreshToken, "grantType": "refreshToken"},
  //     );
  //     if (validStatusCode.contains(res.statusCode) && res.data != null) {
  //       await handler?.onSuccess?.call(SwAuthModel.fromJson(res.data['data']));
  //       return;
  //     }
  //     await handler?.getErrorHandler(res.statusCode)?.call();
  //   } on DioException catch (e) {
  //     await handler?.getErrorHandler(e.response?.statusCode)?.call();
  //   } catch (e) {
  //     logOut();
  //     logger.e('Error in updating user api', error: e);
  //   }
  // }
  //
  // Future<void> getUserSettings({ResponseHandler<SettingModel>? handler}) async {
  //   try {
  //     final res = await apiClient.request(
  //       path: NetworkConstants.userSettings,
  //       type: RequestType.get,
  //     );
  //     if (validStatusCode.contains(res.statusCode) &&
  //         res.data?['data'] != null) {
  //       await handler?.onSuccess?.call(SettingModel.fromJson(res.data['data']));
  //       return;
  //     }
  //   } catch (e) {
  //     logger.e('Error while fetching user setting api', error: e);
  //   }
  // }
  //
  // Future<SettingModel?> updateSetting(SettingModel settingModel) async {
  //   try {
  //     final res = await apiClient.request(
  //         path: NetworkConstants.updateUserSettings,
  //         type: RequestType.put,
  //         data: settingModel.toJson());
  //     if (validStatusCode.contains(res.statusCode) &&
  //         res.data?['data'] != null) {
  //       return SettingModel.fromJson(res.data['data']);
  //     }
  //     return null;
  //   } catch (e) {
  //     logger.e('Error in updating user setting Model', error: e);
  //   }
  //   return null;
  // }
}

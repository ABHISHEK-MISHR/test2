import 'package:test2/services/api.service.dart';

import '../constants/NetworkConstants.dart';
import '../constants/common_utils.dart';
import '../constants/log_utils.dart';
import '../utils/enum_utils.dart';

class TestRepository {
  final ApiClient _apiClient;

  TestRepository({required ApiClient apiClient}) : _apiClient = apiClient;


  Future<List<Post>?> getHolidayBanner({
    Function(int)? onFetchCount
  }) async {
    try {
      final res = await _apiClient.request(
        path: NetworkConstants.health,
        type: RequestType.get,
      );
      if (validStatusCode.contains(res.statusCode) &&
          res.data?['data'] != null) {
        return (res.data['data'] as List)
            .map((e) => Post.fromJson(e))
            .toList();
      }
      return null;
    } catch (e) {
      logger.e('Error while fetching holiday banner from api', error: e);
    }
    return null;
  }


}



class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
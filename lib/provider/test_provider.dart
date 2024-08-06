import 'package:test2/provider/base_provider.dart';
import 'package:test2/repo/repository.dart';

import '../constants/log_utils.dart';

class TestProvider extends BaseChangeNotifierProvider {
  final TestRepository _testRepository;
  Post? post;

  TestProvider({
    required TestRepository testRepository,
  }) : _testRepository = testRepository {
    getHolidayBanner();
  }

  Future<bool> getHolidayBanner() async {
    bool success = false;
    setBusyForObject(getHolidayBanner, true);
    try {
      final res = await _testRepository.getHolidayBanner();
      if (res != null) {
        post = res.first;

        success = true;
      }
    } catch (e) {
      logger.e('Error while fetching event Categories', error: e);
    }

    setBusyForObject(getHolidayBanner, false);

    return success;
  }
}

import 'dart:developer';
import '../utils/file_collection.dart';

final notifierProvider =
    AsyncNotifierProvider<NotificationNotifier, NotificationMode>(() {
  return NotificationNotifier();
});

class NotificationMode {
  GetCurrentAppVersionModel? commonApiResponseModel =
      GetCurrentAppVersionModel();
  CommonApiResponseModel? checkStatusInRIL = CommonApiResponseModel();
}

class NotificationNotifier extends AsyncNotifier<NotificationMode> {
  final NotificationMode _onNotificationMode = NotificationMode();

  // --------------------- Get Notification --------------------- //

  Future<GetCurrentAppVersionModel?> apiNotifyListnerList(
      BuildContext context) async {
    try {
      EasyLoading.show(status: 'loading...');
      _onNotificationMode.checkStatusInRIL = await checkUserinRIL(context);
      if (_onNotificationMode.checkStatusInRIL?.status == 'true') {
        EasyLoading.dismiss();
        _onNotificationMode.commonApiResponseModel =
            await ApiService().getCurrentVersionCheck();
      } else {
        EasyLoading.dismiss();
        toast(_onNotificationMode.checkStatusInRIL?.message ?? '');
      }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    return _onNotificationMode.commonApiResponseModel;
  }

  @override
  build() {
    return _onNotificationMode;
  }
}

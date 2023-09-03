// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import '../api_service/model/qr_inventory_detail_model.dart';
import '../utils/file_collection.dart';

final homeScreenNotifierProvider =
    AsyncNotifierProvider.autoDispose<HomeScreenNotifier, OnHomeScreenMode>(() {
  return HomeScreenNotifier();
});

class OnHomeScreenMode {
  final UserDetail? userdata = UserData.geUserData();
  final TextEditingController searchController = TextEditingController();
  QRInventoryDetailModel? qrInventoryDetailModel = QRInventoryDetailModel();
  CommonApiResponseModel? checkStatusInRIL = CommonApiResponseModel();
}

class HomeScreenNotifier extends AutoDisposeAsyncNotifier<OnHomeScreenMode> {
  final OnHomeScreenMode _onHomeScreenMode = OnHomeScreenMode();

  // --------------------- Get QR Inventory Detail  --------------------- //

  Future<(QRInventoryDetailModel, CommonApiResponseModel)> apiQRInventoryDetail(
      BuildContext context) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        EasyLoading.show(status: 'loading...');
        _onHomeScreenMode.checkStatusInRIL = await checkUserinRIL(context);
        if (_onHomeScreenMode.checkStatusInRIL?.status == 'true') {
          EasyLoading.dismiss();
          _onHomeScreenMode.qrInventoryDetailModel = await ApiService()
              .qrInventoryDetailCheck(_onHomeScreenMode.searchController.text);
        } else {
          EasyLoading.dismiss();
          log('message: ${_onHomeScreenMode.checkStatusInRIL?.message}');
          // toast(_onHomeScreenMode.checkStatusInRIL?.message ?? '');
        }
      } else {
        EasyLoading.dismiss();
        await showMyDialog(context, 'Permission Required',
            'Please enable location to access this app', () async {
          Navigator.pop(context);
          Navigator.pop(context);
          AppSettings.openAppSettings(type: AppSettingsType.location);
        }, istwobutton: false, actionButtonText2: 'Go to Settings');
      }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    return (
      _onHomeScreenMode.qrInventoryDetailModel as QRInventoryDetailModel,
      _onHomeScreenMode.checkStatusInRIL as CommonApiResponseModel
    );
  }

  @override
  build() {
    return _onHomeScreenMode;
  }
}

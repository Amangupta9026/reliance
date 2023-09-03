// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import '../api_service/model/app_user_mapped_project_model.dart';
import '../utils/file_collection.dart';

final workFlowNotifierProvider =
    AsyncNotifierProvider.autoDispose<WorkFlowNotifier, OnWorkFlowMode>(() {
  return WorkFlowNotifier();
});

class OnWorkFlowMode {
  final UserDetail? userdata = UserData.geUserData();

  AppUserMappedProjectModel? appUserMappedModel = AppUserMappedProjectModel();
  CommonApiResponseModel? checkStatusInRIL = CommonApiResponseModel();

    //Unit Access Data
  List<String>? unitAccess = [
    'UIOM - Outward',
    'UIOM - Inward',
    'UINSTALLED',
  ];

  // Workshop Access Data
  List<String>? workShopAccess = [
    'WIOM - Inward',
    'WWIP	WORKSHOP',
    'WIOM - Outward',
  ];

  String? userAccessDropDownValue;
  String? selectProjectDropDownValue;
}

class WorkFlowNotifier extends AutoDisposeAsyncNotifier<OnWorkFlowMode> {
  final OnWorkFlowMode _onWorkFlowMode = OnWorkFlowMode();

  // --------------------- Get QR Inventory Detail  --------------------- //

  Future<(AppUserMappedProjectModel, CommonApiResponseModel)>
      apiAppUserMappedProject(BuildContext context) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        EasyLoading.show(status: 'loading...');
        _onWorkFlowMode.checkStatusInRIL = await checkUserinRIL(context);
        if (_onWorkFlowMode.checkStatusInRIL?.status == 'true') {
          EasyLoading.dismiss();
          _onWorkFlowMode.appUserMappedModel =
              await ApiService().workFlowAPPUserMapped();
        } else {
          EasyLoading.dismiss();
          log('message: ${_onWorkFlowMode.checkStatusInRIL?.message}');
          // toast(_onHomeScreenMode.checkStatusInRIL?.message ?? '');
        }
      } else {
        EasyLoading.dismiss();
        await showMyDialog(context, 'Permission Required',
            'Please enable location to access this app', () async {
          Navigator.of(context).pop();
          context.pushReplacementNamed(RouteNames.mainScreen);
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
      _onWorkFlowMode.appUserMappedModel as AppUserMappedProjectModel,
      _onWorkFlowMode.checkStatusInRIL as CommonApiResponseModel
    );
  }

  @override
  build() {
    return _onWorkFlowMode;
  }
}

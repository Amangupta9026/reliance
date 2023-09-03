import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../local/pref_names.dart';
import '../../local/prefs.dart';
import '../../local/user_details.dart';
import '../model/app_user_mapped_project_model.dart';
import '../model/common_api_response_model.dart';
import '../model/get_currentVersion_model.dart';
import '../model/login_model.dart';
import '../model/qr_inventory_detail_model.dart';
import 'api_constant.dart';
import 'dio_client.dart';

class ApiService {
  // --------------------- Login API --------------------- //

  Future<LoginModel?> postLoginUser(Map<String, String> body) async {
    try {
      final response = await dio
          .post(APIConstants.apiBaseUrl + APIConstants.loginAPI, data: body);

      if (response.statusCode == 200) {
        final loginData = LoginModel.fromJson(response.data);
        if (loginData.status == "true") {
          Prefs.setString(PrefNames.userData, jsonEncode(loginData.userDetail));
        }

        return loginData;
      } else {
        return LoginModel(
            status: "false", message: "Something went wrong", userDetail: null);
      }
    } catch (e) {
      log(e.toString(), name: 'login');
    }
    return LoginModel(
        status: "false", message: "Something went wrong", userDetail: null);
  }

  // --------------------- Login Cookies API --------------------- //

  Future<CommonApiResponseModel?> postLoginUserCookies(
      Map<String, dynamic> body) async {
    var userdata = UserData.geUserData();
    try {
      final response = await dio.post(
          APIConstants.apiBaseUrl + APIConstants.loginCookiesAPI,
          options: Options(headers: {"authtoken": userdata?.authToken}),
          data: body);

      if (response.statusCode == 200) {
        log(json.encode(response.data), name: 'login Cookies api');
        return CommonApiResponseModel.fromJson(response.data);
      } else {
        return CommonApiResponseModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'loginCookies');
    }
    return CommonApiResponseModel(
        status: "false", message: "Something went wrong");
  }

  // --------------------- LogOut API --------------------- //
  Future<CommonApiResponseModel?> logoutUser() async {
    final userdata = UserData.geUserData();
    try {
      final response = await dio.post(
          APIConstants.apiBaseUrl + APIConstants.appUserLogout,
          options: Options(headers: {"authtoken": userdata?.authToken}),
          data: {'userid': userdata?.userid});

      if (response.statusCode == 200) {
        //  log(json.encode(response.data), name: 'logout api');
        return CommonApiResponseModel.fromJson(response.data);
      } else {
        return CommonApiResponseModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'logout User');
    }
    return CommonApiResponseModel(
        status: "false", message: "Something went wrong");
  }

  // --------------------- Get Current Version Check API --------------------- //

  Future<GetCurrentAppVersionModel?> getCurrentVersionCheck() async {
    try {
      final response = await dio
          .get(APIConstants.apiBaseUrl + APIConstants.getCurrentAppVersion);

      if (response.statusCode == 200) {
        // log(json.encode(response.data), name: 'current version api');
        return GetCurrentAppVersionModel.fromJson(response.data);
      } else {
        return GetCurrentAppVersionModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'current version');
    }
    return GetCurrentAppVersionModel(
        status: "false", message: "Something went wrong");
  }

  // --------------------- Get QR Inventory Detail API --------------------- //
  Future<QRInventoryDetailModel?> qrInventoryDetailCheck(String qrCode) async {
    final userdata = UserData.geUserData();
    try {
      final response = await dio.post(
          APIConstants.apiBaseUrl + APIConstants.getInventoryDetailByUid,
          options: Options(headers: {"authtoken": userdata?.authToken}),
          data: {'userid': userdata?.userid, "inventoryuid": qrCode});

      if (response.statusCode == 200) {
        //  log(json.encode(response.data), name: 'qr inventory detail');
        return QRInventoryDetailModel.fromJson(response.data);
      } else {
        return QRInventoryDetailModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'qr inventory detail');
    }
    return QRInventoryDetailModel(
        status: "false", message: "Something went wrong");
  }

  // --------------------- Check User In RIL Premises API --------------------- //
  Future<CommonApiResponseModel?> checkUserInRILPremises(
      double lat, double long) async {
    final userdata = UserData.geUserData();
    try {
      final response = await dio.post(
          APIConstants.apiBaseUrl + APIConstants.checkUserInRilPremises,
          options: Options(headers: {"authtoken": userdata?.authToken}),
          data: {'userid': userdata?.userid, "lat": lat, "long": long});

      if (response.statusCode == 200) {
        // log(json.encode(response.data), name: 'UserIn RILPremises');
        return CommonApiResponseModel.fromJson(response.data);
      } else {
        return CommonApiResponseModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'UserIn RILPremises');
    }
    return CommonApiResponseModel(
        status: "false", message: "Something went wrong");
  }

  // --------------------- Notification API --------------------- //
  Future<CommonApiResponseModel?> getNotification() async {
    final userdata = UserData.geUserData();
    try {
      final response = await dio.get(
          APIConstants.apiBaseUrl + APIConstants.checkUserInRilPremises,
          options: Options(headers: {"authtoken": userdata?.authToken}));
      if (response.statusCode == 200) {
        // log(json.encode(response.data), name: 'UserIn RILPremises');
        return CommonApiResponseModel.fromJson(response.data);
      } else {
        return CommonApiResponseModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'Notification');
    }
    return CommonApiResponseModel(
        status: "false", message: "Something went wrong");
  }

  // ---------- WorkFlow APP User Mapped Project -------------- //
  Future<AppUserMappedProjectModel?> workFlowAPPUserMapped() async {
    final userdata = UserData.geUserData();
    try {
      final response = await dio.post(
          APIConstants.apiBaseUrl + APIConstants.appUserMappedProject,
          options: Options(headers: {"authtoken": userdata?.authToken}),
          data: {'userid': userdata?.userid, "plantid": userdata?.plantid});

      if (response.statusCode == 200) {
        log(json.encode(response.data), name: 'appUserMappedProject');
        return AppUserMappedProjectModel.fromJson(response.data);
      } else {
        return AppUserMappedProjectModel(
            status: "false", message: "Something went wrong");
      }
    } catch (e) {
      log(e.toString(), name: 'appUserMappedProject');
    }
    return AppUserMappedProjectModel(
        status: "false", message: "Something went wrong");
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:android_id/android_id.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_number/mobile_number.dart';
import '../utils/file_collection.dart';

final logInNotifierProvider =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, LogInMode>(() {
  return LoginNotifier();
});

class LogInMode {
  bool isPasswordVisible = false, colorChange = false;

  String mobileNumber = '', removeCountryCode = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Device Info
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  String? model = '',
      deviceVersion = '',
      manufacturer = '',
      brand = '',
      deviceId = '',
      androidId = '',
      ipv4 = '';
  Map<String, dynamic>? deviceDataFailed = <String, dynamic>{};

  //Android ID
  final androidIdPlugin = const AndroidId();

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
}

class LoginNotifier extends AutoDisposeAsyncNotifier<LogInMode> {
  final LogInMode _logInMode = LogInMode();

  // Sign In Button Click
  void signIn(BuildContext context, String? latitude, String? longitude) async {
    EasyLoading.show(status: 'Loading...');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      final latlong = await Geolocator.getCurrentPosition();
      latitude = latlong.latitude.toString();
      longitude = latlong.longitude.toString();
      log(latlong.toString());

      try {
        // Login Data API
        Map<String, String> loginBody = {
          "email": _logInMode.emailController.text.toLowerCase(),
          "password": _logInMode.passwordController.text,
          "mobileno": _logInMode.removeCountryCode,
          "deviceid": _logInMode.androidId ?? '',
          "lat": '22.36035174740625',
          //latitude ?? '',
          "long": '69.8492976611504',
          //  longitude ?? '',
        };

        log(loginBody.toString(), name: 'login body');

        if (_logInMode.emailController.text.isNotEmpty &&
            _logInMode.passwordController.text.isNotEmpty &&
            _logInMode.emailController.text.isValidEmail()) {
          // context.pushReplacementNamed(RouteNames.mobileNumberGet,
          //     pathParameters: {
          //       'mobileNumber': _logInMode.removeCountryCode,
          //     });

          LoginModel? response = await ApiService().postLoginUser(loginBody);
          if (response?.status == "true") {
            UserDetail? userdata = UserData.geUserData();

            //   Login Cookies Data API
            Map<String, dynamic> loginCookiesBody = {
              "userid": userdata?.userid,
              "lat": '22.36035174740625',
              // latitude ?? '',
              "long": '69.8492976611504',
              //latitude ?? '',
              "ipadd": _logInMode.ipv4 ?? '',
              "device": _logInMode.model ?? '',
              "deviceid": _logInMode.androidId ?? '',
              "devicebrand": _logInMode.brand ?? '',
              "devicemfg": _logInMode.manufacturer ?? '',
              "devicename": _logInMode.model ?? '',
              "deviceos": _logInMode.deviceVersion ?? '',
              "appversion": _logInMode.packageInfo.version,
            };

            log(loginCookiesBody.toString(), name: 'login body');
            CommonApiResponseModel? commonApiResponseModel =
                await ApiService().postLoginUserCookies(loginCookiesBody);
            if (commonApiResponseModel?.status == "true") {
              Prefs.setBool(PrefNames.isLogin, true);
              EasyLoading.dismiss();
              toast('Login Success');
              context.pushReplacementNamed(RouteNames.mainScreen);
            } else {
              EasyLoading.dismiss();
              toast(commonApiResponseModel?.message ?? 'Login Failed');
            }
          } else {
            EasyLoading.dismiss();
            toast(response?.message ?? 'Login Failed');
          }
        } else if (_logInMode.emailController.text.isNotEmpty &&
            _logInMode.passwordController.text.isNotEmpty &&
            !_logInMode.emailController.text.isValidEmail()) {
          EasyLoading.dismiss();
          toast('Check your email');
        } else {
          EasyLoading.dismiss();
          toast('Please fill email and password');
        }
      } catch (e) {
        log(e.toString(), name: 'login');
      }
      EasyLoading.dismiss();
    
    } else {
      EasyLoading.dismiss();
      toast('Please enable location service');
    }
  }

  // --------------------- Phone Permission --------------------- //

  Future<void> phonePermission() async {
    try {
      if (await Permission.phone.isDenied) {
        await AppUtils.permissionRequest(Permission.phone);
      } else if (await Permission.phone.isPermanentlyDenied) {
        log('permanently denied phone');
        await AppUtils.permissionRequest(Permission.phone);
      } else {
        await AppUtils.permissionRequest(Permission.phone);
      }
    } catch (e) {
      log(e.toString(), name: 'phonePermission');
    }
    await mobileNumberPermission();
  }

  // --------------------- deviceInfo  --------------------- //

  Future<void> deviceInfo() async {
    try {
      _logInMode.androidInfo = await _logInMode.deviceInfoPlugin.androidInfo;
      _logInMode.model = _logInMode.androidInfo?.model ?? '';
      _logInMode.deviceVersion = _logInMode.androidInfo?.version.release ?? '';
      _logInMode.manufacturer = _logInMode.androidInfo?.manufacturer ?? '';
      _logInMode.brand = _logInMode.androidInfo?.brand ?? '';
      _logInMode.androidId = await _logInMode.androidIdPlugin.getId();
      _logInMode.ipv4 = await Ipify.ipv4();
    } catch (e) {
      log(e.toString(), name: 'deviceInfo');
    }
  }

  // Mobile Number GET
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    try {
      _logInMode.mobileNumber = (await MobileNumber.mobileNumber ?? '');

      if (MobileNumber.mobileNumber != null &&
          _logInMode.mobileNumber.isNotEmpty) {
        _logInMode.removeCountryCode =
            '+${_logInMode.mobileNumber.substring(2)}'; // bezkoder
      }
    } catch (e) {
      log(e.toString(), name: 'mobileNumber');
    }
    // state = AsyncData(_logInMode);
  }

  // -------------- Mobile Number Permission when page is open -------------- //

  Future<void> mobileNumberPermission() async {
    try {
      MobileNumber.listenPhonePermission((isPermissionGranted) {
        if (isPermissionGranted) {
          initMobileNumberState();
        } else {
          mobileNumberPermission();
        }
      });

      initMobileNumberState();
    } catch (e) {
      log(e.toString(), name: 'mobileNumberPermission');
    }
  }

  // Package info init
  Future<void> initPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      _logInMode.packageInfo = info;
      state = AsyncData(_logInMode);
    } catch (e) {
      log(e.toString(), name: 'initPackageInfo');
    }
  }

  // Password visibility
  void isPasswordVisible() {
    _logInMode.isPasswordVisible = !_logInMode.isPasswordVisible;
    state = AsyncData(_logInMode);
  }

  // Button Color Change
  void buttonColorChange() {
    if (_logInMode.emailController.text.isNotEmpty &&
        _logInMode.passwordController.text.isNotEmpty) {
      _logInMode.colorChange = true;
    } else {
      _logInMode.colorChange = false;
    }
    state = AsyncData(_logInMode);
  }

  // --------------------- Check Version --------------------- //
  void checkVersion() async {
    try {
      GetCurrentAppVersionModel? getCurrentAppVersionModel =
          await ApiService().getCurrentVersionCheck();

      if (getCurrentAppVersionModel?.status == 'true' &&
          getCurrentAppVersionModel?.currentVersion != null) {
        if (getCurrentAppVersionModel?.currentVersion ==
            _logInMode.packageInfo.version) {
        } else {
          toast('new version available');
        }
      }
    } catch (e) {
      log(e.toString(), name: 'loginCheckVersion');
    }
  }

  @override
  build() {
    deviceInfo();
    checkVersion();
    return _logInMode;
  }
}

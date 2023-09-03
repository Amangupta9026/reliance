// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'file_collection.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class AppUtils {
  // Permission for request
  static Future<void> permissionRequest(Permission permission) async {
    final status = await permission.request();
    debugPrint(status.toString());
  }

  static Future<bool> internetCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  // Internet Check
  static Future<void> checkInternet(BuildContext context) async {
    final isInternetCheck = await AppUtils.internetCheck();
    if (isInternetCheck) {
    } else {
      showMyDialog(context, 'No Internet Connection',
          'Please check your internet connection', () async {
        context.pop();
        checkInternet(context);
      }, istwobutton: false, barrierDismissible: false);
      false;
    }
  }

  // static void loadNextScreen(BuildContext context) async {
  //   Timer(const Duration(seconds: 1), () async {
  //     var location = Location();
  //     bool enabled = await location.serviceEnabled();
  //     if (!enabled) {
  //       context.pushReplacementNamed(RouteNames.customLocationScreen);
  //     } else {
  //       context.pushReplacementNamed(RouteNames.logInScreen);
  //     }
  //   });
  // }
}

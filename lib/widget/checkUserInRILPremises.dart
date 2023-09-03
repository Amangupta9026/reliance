// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import '../utils/file_collection.dart';

// --------------------- After Login Check User in RIL Premises --------------------- //

Future<CommonApiResponseModel?> checkUserinRIL(BuildContext context) async {
  CommonApiResponseModel? response;
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled) {
    final latlong = await Geolocator.getCurrentPosition();
    double latitude = 
    // latlong.latitude;

    22.338260734789518;
    double longitude =
        // latlong.longitude;
        69.86543056561932;
    //  log(latlong.toString());

    try {
      response = await ApiService().checkUserInRILPremises(latitude, longitude);
    } catch (e) {
      log(e.toString(), name: 'login');
    }
  } else {
    // toast('Please enable location service');
    EasyLoading.dismiss();
  }
  return response;
}

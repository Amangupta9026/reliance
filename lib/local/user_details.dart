import 'dart:convert';
import 'dart:developer';
import '../api_service/model/login_model.dart';
import 'pref_names.dart';
import 'prefs.dart';

// class UserData {
//   static UserDetail geUserData() {
//     final user = jsonDecode(Prefs.getString(PrefNames.userData) ?? '');

//     return UserDetail.fromJson(user);
//   }
// }

class UserData {
  static UserDetail? geUserData() {
    try {
      final String? data = Prefs.getString(PrefNames.userData);
      if (data != null) {
        final json = jsonDecode(data);
        return UserDetail.fromJson(json);
      }
    } catch (e) {
      log("$e");
    }
    return null;
  }
}

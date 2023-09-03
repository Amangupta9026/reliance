class APIConstants {
  static const String baseUrl = "http://k2aidev.k2ai.com:8081/";

  static const String apiUrl = "${baseUrl}be_api/app/";
  static const String apiBaseUrl = "${apiUrl}auth/";

  static const connectionTimeOut = 300000;
  static const receiveTimeOut = 300000;

  /// API Requests
  static const String loginAPI = "app_user_login";
  static const String loginCookiesAPI = "app_user_login_cookies";
  static const String appUserLogout = "app_user_logout";
  static const String getCurrentAppVersion = "get_current_app_version";

  static const String getInventoryDetailByUid = "get_inventory_detail_by_uid";
  static const String checkUserInRilPremises = "check_user_in_ril_premises";
  static const String appUserMappedProject = "get_appuser_mapped_projects";

  //static const String notification = "notification";
}

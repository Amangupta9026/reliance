import 'app_route_file_manager.dart';

bool isUserLogin = Prefs.getBool(PrefNames.isLogin) ?? false;

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  Offset? begin,
}) {
  return CustomTransitionPage<T>(
    fullscreenDialog: true,
    transitionDuration: const Duration(seconds: 1),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          alwaysIncludeSemantics: true, opacity: animation, child: child);

      // SlideTransition(
      //   position: Tween<Offset>(
      //     begin: const Offset(0, 1.0),
      //     end: Offset.fromDirection(0, 1.0),
      //   ).animate(animation),
      //   child: child,
      // );
    },
  );
}

String getInitialRoute() {
  switch (isUserLogin) {
    case false:
      return RouteNames.onBoarding;
    default:
      return RouteNames.mainScreen;
  }
}

final appRoute = GoRouter(initialLocation: getInitialRoute(), routes: [
  GoRoute(
    path: RouteNames.onBoarding,
    name: RouteNames.onBoarding,
    builder: (context, state) {
      return const OnBoarding();
    },
  ),

  GoRoute(
    path: RouteNames.allPermissionList,
    name: RouteNames.allPermissionList,
    builder: (context, state) {
      return const PermList();
    },
  ),

  GoRoute(
      path: RouteNames.logInScreen,
      name: RouteNames.logInScreen,
      builder: (context, state) {
        return const LoginScreen();
      }),

  GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) {
        return HomePage();
      }),

  GoRoute(
      path: RouteNames.mainScreen,
      name: RouteNames.mainScreen,
      builder: (context, state) {
        return const MainScreen();
      }),

  GoRoute(
    path: RouteNames.profile,
    name: RouteNames.profile,
    builder: (context, state) {
      return const ProfileScreen();
    },
  ),

  GoRoute(
    path: RouteNames.settingScreen,
    name: RouteNames.settingScreen,
    builder: (context, state) {
      return const Setting();
    },
  ),

  GoRoute(
    path: RouteNames.notification,
    name: RouteNames.notification,
    builder: (context, state) {
      return const NotificationScreen();
    },
  ),

  GoRoute(
    path: RouteNames.aboutApp,
    name: RouteNames.aboutApp,
    builder: (context, state) {
      return const AboutApp();
    },
  ),

  GoRoute(
    path: RouteNames.helpSupport,
    name: RouteNames.helpSupport,
    builder: (context, state) {
      return const HelpSupport();
    },
  ),

  GoRoute(
    path: RouteNames.scanQR,
    name: RouteNames.scanQR,
    builder: (context, state) {
      return const ScanQRCode();
    },
  ),

  GoRoute(
    path: RouteNames.workFlow,
    name: RouteNames.workFlow,
    builder: (context, state) {
      return const WorkFlow();
    },
  ),

  GoRoute(
    path: RouteNames.userLocationNotPremises,
    name: RouteNames.userLocationNotPremises,
    builder: (context, state) {
      CommonApiResponseModel commonApiResponseModel =
          state.extra as CommonApiResponseModel;
      return UserLocationNotPremises(
        response: commonApiResponseModel,
      );
    },
  ),

  GoRoute(
    path: RouteNames.searchInventoryDetail,
    name: RouteNames.searchInventoryDetail,
    builder: (context, state) {
      // QRInventoryDetailModel qrInventoryDetailModel =
      //     state.extra as QRInventoryDetailModel;
      return const SearchInventoryDetails(
          // qrInventoryDetailModel: qrInventoryDetailModel,
          );
    },
  ),

  // GoRoute(
  //   path: '/mobileNumberGet/:mobileNumber',
  //   name: RouteNames.mobileNumberGet,
  //   builder: (context, state) {
  //     return MobileNumberShow(
  //       mobileNumber: state.pathParameters['mobileNumber'],
  //     );
  //   },
  // ),

  // GoRoute(
  //   path: '/otpScreen/:mobileNumber/:verificationId/:resendToken',
  //   name: RouteNames.otpScreen,
  //   builder: (context, state) {
  //     return OTPScreen(
  //         mobileNumber: state.pathParameters['mobileNumber'] ?? '',
  //         verificationId: state.pathParameters['verificationId'] ?? '',
  //         resendToken: state.pathParameters['resendToken']);
  //   },
  // ),

  // GoRoute(
  //   path: RouteNames.home,
  //   name: RouteNames.home,
  //   pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
  //     context: context,
  //     state: state,
  //     child: HomeScreen(),
  //   ),
]);

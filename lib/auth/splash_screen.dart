// import 'dart:async';
// import '../local/pref_names.dart';
// import '../local/prefs.dart';
// import '../utils/file_collection.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool visible = false;

//   @override
//   void initState() {
//     isLogin();
//     super.initState();
//   }

//   void isLogin() {
//     Timer(const Duration(seconds: 2), () {
//       if (Prefs.getBool(PrefNames.isLogin) ?? false) {
//         context.pushReplacementNamed(RouteNames.home);
//       } else {
//         context.pushReplacementNamed(RouteNames.onBoarding);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//         body: Container(
//           decoration: AppUtils.decoration1(),
//           height: double.infinity,
//           width: double.infinity,
//           child: Center(
//             child: Image.asset(logo),
//           ),
//         ),
//       ),
//     );
//   }
// }

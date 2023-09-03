// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../utils/file_collection.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with WidgetsBindingObserver {
  double? latitude = 0.0, longitude = 0.0;
  bool askingLocationPermission = false;
  Position? latlong;

  @override
  void initState() {
    log('initState');
    appLocation();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!askingLocationPermission) {
        appLocation();
      }
    }
  }

  Future<void> appLocation() async {
    askingLocationPermission = true;
    if (latlong != null) {
      return;
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Location().requestService();
      return;
    }

    LocationPermission locationpermission =
        await Geolocator.requestPermission();
    if (locationpermission == LocationPermission.deniedForever) {
      await showMyDialog(context, 'Permission Required',
          'Please enable location to access this app', () async {
        Navigator.pop(context);
        await openAppSettings();
      }, istwobutton: false, actionButtonText2: 'Go to Settings');
    } else if (locationpermission == LocationPermission.denied) {
      locationpermission = await Geolocator.requestPermission();
    } else {
      latlong = await Geolocator.getCurrentPosition();
      latitude = latlong?.latitude ?? 0.0;
      longitude = latlong?.longitude ?? 0.0;
      log(latlong.toString(), name: 'latlong');
    }
    askingLocationPermission = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final refRead = ref.read(logInNotifierProvider.notifier);
    refRead.initPackageInfo();
    refRead.phonePermission();

    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Stack(children: [
            // Image Illustration
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                  image: const AssetImage(dssiqLogo),
                ),
              ),
            ),

            Consumer(builder: (context, ref, child) {
              return Positioned(
                  left: 0,
                  right: 20,
                  bottom: 0,
                  top: 10,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'v ${ref.watch(logInNotifierProvider).value?.packageInfo.version ?? ''}',
                        style: const TextStyle(color: secondaryColor),
                      )));
            }),

            // Content
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 20, right: 15, top: 40.0, bottom: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(
                                child: Text('Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              const SizedBox(height: 10.0),
                              const Center(
                                child: Text(
                                    'Please enter details to proceed further',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ),
                              const SizedBox(height: 26.0),

                              // Email
                              const Text('Email',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const SizedBox(height: 10.0),
                              Consumer(builder: (context, ref, child) {
                                final refWatch =
                                    ref.watch(logInNotifierProvider);
                                final refRead =
                                    ref.read(logInNotifierProvider.notifier);

                                return TextFormFieldWidget(
                                  hintText: 'Enter your email',
                                  controller: refWatch.value?.emailController,
                                  suffixIcon: const Icon(Icons.email,
                                      color: primaryColor),
                                  onChanged: (value) =>
                                      refRead.buttonColorChange(),
                                );
                              }),

                              // Password
                              const SizedBox(height: 26.0),
                              const Text('Password',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const SizedBox(height: 10.0),
                              Consumer(builder: (context, ref, child) {
                                final refWatch =
                                    ref.watch(logInNotifierProvider);
                                final refRead =
                                    ref.read(logInNotifierProvider.notifier);

                                return TextFormFieldWidget(
                                  hintText: 'Enter your password',
                                  obscureText:
                                      !refWatch.value!.isPasswordVisible,
                                  controller:
                                      refWatch.value?.passwordController,
                                  onChanged: (value) =>
                                      refRead.buttonColorChange(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      color: primaryColor,
                                      refWatch.value!.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: refRead.isPasswordVisible,
                                  ),
                                );
                              }),

                              // Submit Button

                              const SizedBox(height: 40.0),
                              Consumer(builder: (context, ref, child) {
                                final refWatch =
                                    ref.watch(logInNotifierProvider);
                                final refRead =
                                    ref.read(logInNotifierProvider.notifier);

                                return buttonWithIconSizedBox(
                                    refWatch.value!.colorChange
                                        ? primaryColor
                                        : offlineButtonColor,
                                    Icons.verified_user,
                                    "Proceed Securly", () {
                                  refRead.signIn(context, latitude.toString(),
                                      longitude.toString());
                                });
                              }),
                            ],
                          )),
                    ))),
          ]),
        ));
  }
}

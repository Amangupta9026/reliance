import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import '../utils/file_collection.dart';
import '../widget/animated_switch.dart';

class PermList extends StatefulWidget {
  const PermList({Key? key}) : super(key: key);

  @override
  State<PermList> createState() => _PermListState();
}

class _PermListState extends State<PermList> {
  bool location = false;
  bool phone = false;
  bool camera = false;
  bool gps = false;
  // bool media = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool a = await Permission.location.isGranted;
      bool b = await Permission.phone.isGranted;
      bool c = await Permission.camera.isGranted;
      bool d = await Geolocator.isLocationServiceEnabled();
      // bool e = await Permission.mediaLibrary.isGranted &&
      //     await Permission.manageExternalStorage.isGranted &&
      //     false;
      setState(() {
        location = a;
        phone = b;
        camera = c;
        gps = d;
        // media = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 40),
          child: Column(children: [
            const Center(
                child: Text("All Permissions are Compulsory!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 16))),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Row(children: [
                Icon(Icons.location_on_outlined, color: primaryColor, size: 30),
                SizedBox(width: 10),
                Text("Location",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800))
              ]),
              AnimatedSwitch(
                  enabled: location,
                  type: "location",
                  onSonChanged: (val) {
                    log("$val");
                    setState(() {
                      location = val;
                    });
                  })
            ]),
            const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10, 0, 20),
                child: Text(
                    "Location permission is required to access your location",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Row(children: [
                Icon(Icons.phone, color: primaryColor, size: 30),
                SizedBox(width: 10),
                Text("Phone",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800))
              ]),
              AnimatedSwitch(
                  enabled: phone,
                  type: "phone",
                  onSonChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  })
            ]),
            const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10, 0, 20),
                child: Text(
                    "Phone permission is required to provide better access to the app",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Row(children: [
                Icon(Icons.photo_camera_outlined,
                    color: primaryColor, size: 30),
                SizedBox(width: 10),
                Text("Camera Access",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800))
              ]),
              AnimatedSwitch(
                  enabled: camera,
                  type: "camera",
                  onSonChanged: (val) {
                    setState(() {
                      camera = val;
                    });
                  })
            ]),
            const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10, 0, 30),
                child: Text("Camera permission is required to scan QR code",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Row(children: [
                Icon(Icons.gps_fixed_outlined, color: primaryColor, size: 30),
                SizedBox(width: 10),
                Text("GPS Access",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800))
              ]),
              AnimatedSwitch(
                  enabled: gps,
                  type: "gps",
                  onSonChanged: (val) {
                    setState(() {
                      gps = val;
                    });
                  })
            ]),
            const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10, 0, 30),
                child: Text(
                    "GPS permission is required to access your location",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)),
            // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //   const Row(children: [
            //     Icon(Icons.perm_media, color: primaryColor, size: 30),
            //     SizedBox(width: 10),
            //     Text("Media Access",
            //         style: TextStyle(
            //             color: textColor,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w800))
            //   ]),
            //   AnimatedSwitch(
            //       enabled: media,
            //       type: "media",
            //       onSonChanged: (val) {
            //         setState(() {
            //           media = val;
            //         });
            //       })
            // ]),
            // const Padding(
            //     padding: EdgeInsets.fromLTRB(10.0, 10, 0, 30),
            //     child: Text(
            //         "Media permission is required for storage permission",
            //         style: TextStyle(
            //             color: textColor,
            //             fontSize: 15,
            //             fontWeight: FontWeight.w500),
            //         textAlign: TextAlign.start)),
            buttonSizedBox(
                location && phone && camera && gps
                    ? primaryColor
                    : offlineButtonColor,
                "Grant Access", () async {
              if (location && phone && camera && gps) {
                context.pushReplacementNamed(RouteNames.logInScreen);
              } else {
                toast("Please grant all permissions");
              }
            })
          ]),
        )));
  }
}

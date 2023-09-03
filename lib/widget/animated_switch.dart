// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reliance_industries_limited_ril/utils/colors.dart';

typedef IntCallback = void Function(bool data);
typedef BoolCallback = void Function(bool data);

class AnimatedSwitch extends StatefulWidget {
  final BoolCallback? onSonChanged;
  bool enabled = false;
  String type = "";
  AnimatedSwitch(
      {required this.onSonChanged,
      required this.enabled,
      required this.type,
      super.key});

  @override
  AnimatedSwitchState createState() => AnimatedSwitchState();
}

class AnimatedSwitchState extends State<AnimatedSwitch> {
  final animationDuration = const Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.type == "location") {
          if (widget.enabled == false) {
            bool val = await Permission.locationWhenInUse.request().isGranted;
            if (val == true) {
              setState(() {
                widget.enabled = !widget.enabled;
                widget.onSonChanged!(widget.enabled);
              });
            }
          }
        }

        if (widget.type == "phone") {
          if (widget.enabled == false) {
            bool val = await Permission.phone.request().isGranted;
            if (val == true) {
              setState(() {
                widget.enabled = !widget.enabled;
                widget.onSonChanged!(widget.enabled);
              });
            }
          }
        }

        if (widget.type == "camera") {
          if (widget.enabled == false) {
            bool val = await Permission.camera.request().isGranted;
            if (val == true) {
              setState(() {
                widget.enabled = !widget.enabled;
                widget.onSonChanged!(widget.enabled);
              });
            }
          }
        }

        if (widget.type == "gps") {
          if (widget.enabled == false) {
           await Location().requestService();       
            if (await Geolocator.isLocationServiceEnabled()) {
              setState(() {
                widget.enabled = !widget.enabled;
                widget.onSonChanged!(widget.enabled);
              });
            }
          }
        }

        // if (widget.type == "media") {
        //   if (widget.enabled == false) {
        //     bool val = await Permission.mediaLibrary.request().isGranted;
        //     bool val2 = await Permission.photos.request().isGranted;
        //     bool val3 = await Permission.videos.request().isGranted;
        //     bool val4 = await Permission.audio.request().isGranted;
        //     if (val == true || val2 == true || val3 == true || val4 == true) {
        //       setState(() {
        //         widget.enabled = !widget.enabled;
        //         widget.onSonChanged!(widget.enabled);
        //       });
        //     }
        //   }
        // }
      },
      child: AnimatedContainer(
        height: 22,
        width: 46,
        duration: animationDuration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.enabled ? primaryColor : secondaryColor,
        ),
        child: AnimatedAlign(
          duration: animationDuration,
          alignment:
              widget.enabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

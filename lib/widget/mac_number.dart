// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:mac_address/mac_address.dart';

// class MACGET extends StatefulWidget {
//   const MACGET({super.key});

//   @override
//   _MACGETState createState() => _MACGETState();
// }

// class _MACGETState extends State<MACGET> {
//   String _platformVersion = 'Unknown';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await GetMac.macAddress;
//     } on PlatformException {
//       platformVersion = 'Failed to get Device MAC Address.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('MAC Address : $_platformVersion\n'),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:developer';

// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../utils/file_collection.dart';

// final scanQRNotifierProvider =
//     AutoDisposeAsyncNotifierProvider<ScanQRNotifier, ScanQRMode>(() {
//   return ScanQRNotifier();
// });

// class ScanQRMode {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// }

// class ScanQRNotifier extends AutoDisposeAsyncNotifier<ScanQRMode> {
//   final ScanQRMode _scanQRMode = ScanQRMode();

//   // void reassemble() {
//   //   super.reassemble();
//   //   if (Platform.isAndroid) {
//   //     _scanQRMode.controller!.pauseCamera();
//   //   }
//   //   _scanQRMode.controller!.resumeCamera();
//   // }

//   void onQRViewCreated(QRViewController controller) {
//     _scanQRMode.controller = controller;
//     state = AsyncData(_scanQRMode);

//     controller.scannedDataStream.listen((scanData) {
//       _scanQRMode.result = scanData;
//       state = AsyncData(_scanQRMode);
//     });

//     print(_scanQRMode.result);
//     state = AsyncData(_scanQRMode);
//   }

//   void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }

//   void flashOn() async {
//     log('flashOn');
//     await _scanQRMode.controller?.toggleFlash();
//     state = AsyncData(_scanQRMode);
//   }

//   void cameraflip() async {
//     await _scanQRMode.controller?.flipCamera();
//     state = AsyncData(_scanQRMode);
//   }

//   @override
//   build() {
//     return _scanQRMode;
//   }
// }

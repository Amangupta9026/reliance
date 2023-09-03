// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../api_service/model/qr_inventory_detail_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/file_collection.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isflashOn = false;

  CommonApiResponseModel? checkStatusInRIL = CommonApiResponseModel();
  QRInventoryDetailModel? qrInventoryDetailModel = QRInventoryDetailModel();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.stopCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'Scan QR Code',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (qrInventoryDetailModel?.message == null) ...{
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(
                      children: [
                        QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                              borderColor: primaryColor,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: double.infinity),
                          onPermissionSet: (ctrl, p) =>
                              _onPermissionSet(context, ctrl, p),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 20.0, 15.0, 0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await controller?.toggleFlash();
                                    isflashOn = !isflashOn;
                                    setState(() {});
                                  },
                                  child: Icon(
                                      isflashOn
                                          ? Icons.flash_on
                                          : Icons.flash_off,
                                      size: 20,
                                      color: Colors.grey[200]),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    await controller?.flipCamera();
                                    setState(() {});
                                  },
                                  child: Icon(Icons.flip_camera_ios,
                                      size: 20, color: Colors.grey[200]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                },
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: Column(
                    children: [
                      if (qrInventoryDetailModel?.message != null)
                        columnData()
                      else
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text('Scan QR Code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    //
  }

  Widget columnData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (result?.code != null &&
            qrInventoryDetailModel?.status == 'false') ...{
          Center(
            child: Text(
              qrInventoryDetailModel?.message ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        } else ...{
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row('Plant Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.plantname ?? ''),
              const Divider(height: 10, color: secondaryColor),
              row('Unit Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.unitname ?? ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Sub Unit Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.subunitname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Sub Section Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.susectionname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Category Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.categoryname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'RIL Inventory ID',
                  qrInventoryDetailModel?.inventoryItemDetail?.rilInventoryId ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Make',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryMake ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Name',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryName ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Description',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryDesc ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Unit',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryUnit
                          .toString() ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Weight',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryWeight
                          .toString() ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Length, Width, Height',
                  qrInventoryDetailModel?.inventoryItemDetail?.inventoryLwh ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Date',
                  qrInventoryDetailModel
                          ?.inventoryItemDetail?.inventoryPurDate ??
                      ''),
            ],
          )
        }
      ],
    );
  }

  Widget row(String? title, String? value) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 20,
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(height: 10, color: secondaryColor)
          ],
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      setState(() {
        this.controller = controller;
      });
      controller.scannedDataStream.listen((scanData) async {
        setState(() {
          result = scanData;
        });
        log(result?.code.toString() ?? '', name: 'result');
        EasyLoading.show(status: 'loading...');
        checkStatusInRIL = await checkUserinRIL(context);
        if (checkStatusInRIL?.status == 'true') {
          qrInventoryDetailModel =
              await ApiService().qrInventoryDetailCheck(result?.code ?? '');
        } else {
          controller.dispose();
          EasyLoading.dismiss();
          if (mounted) {
            context.pushReplacementNamed(RouteNames.userLocationNotPremises,
                extra: checkStatusInRIL);
          }
        }
        EasyLoading.dismiss();
      });
    } else {
      await showMyDialog(context, 'Permission Required',
          'Please enable location to access this app', () async {
        Navigator.pop(context);
        Navigator.pop(context);
        AppSettings.openAppSettings(type: AppSettingsType.location);
      }, istwobutton: false, actionButtonText2: 'Go to Settings');
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

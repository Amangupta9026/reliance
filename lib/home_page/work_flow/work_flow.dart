// ignore_for_file: file_names, unnecessary_this

import 'dart:developer';
import 'dart:io';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../riverpod/workflow_notifier.dart';
import '../../utils/file_collection.dart';
import '../../widget/dropdown_reusubility.dart';
import '../../widget/user_not_location_premise.dart';

class WorkFlow extends StatefulWidget {
  const WorkFlow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorkFlowState();
}

class _WorkFlowState extends State<WorkFlow> {
  Barcode? workFlowResult;
  QRViewController? workFlowController;
  final GlobalKey workFlowQRKey = GlobalKey(debugLabel: 'QR');
  bool isFlashOn = false;
  final UserDetail? userdata = UserData.geUserData();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      workFlowController?.stopCamera();
    }
    workFlowController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: workFlowResult != null
              ? BottomNavigationBarWidget(
                  buttonName: 'Commit',
                  onButtonPressed: () {
                    toast('Commit Successfully');
                  },
                )
              : const SizedBox(),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const AppBarReusubility(
                  title: 'Work Flow',
                  isBackButton: false,
                ),
                if (workFlowResult == null) ...{
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30),
                    child: Center(
                      child: Text('Scan QR Code',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Stack(
                          children: [
                            QRView(
                              key: workFlowQRKey,
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
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 20.0, 15.0, 0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await workFlowController?.toggleFlash();
                                        isFlashOn = !isFlashOn;
                                        setState(() {});
                                      },
                                      child: Icon(
                                          isFlashOn
                                              ? Icons.flash_on
                                              : Icons.flash_off,
                                          size: 20,
                                          color: Colors.grey[200]),
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        await workFlowController?.flipCamera();
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
                      )),
                },
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      if (workFlowResult != null) ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 40),
                          child: Consumer(builder: (context, ref, child) {
                            final refWatch =
                                ref.watch(workFlowNotifierProvider);

                            return FutureBuilder(
                                future: ref
                                    .read(workFlowNotifierProvider.notifier)
                                    .apiAppUserMappedProject(context),
                                builder: (context, snapshot) {
                                  final (
                                    appUserMappedProjectModel,
                                    commonApiResponseModel
                                  ) = snapshot.data ?? (null, null);
                                  if (!snapshot.hasData) {
                                    log('No Data');
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (workFlowResult != null) ...{
                                        if (commonApiResponseModel?.status ==
                                            'true') ...{
                                          Column(children: [
                                            DropDownWidget(
                                              hintText: refWatch.value
                                                  ?.selectProjectDropDownValue,
                                              dropDownTitle: 'Select Project',
                                              dropDownValue: refWatch.value
                                                      ?.selectProjectDropDownValue ??
                                                  '',
                                              dropDownItem:
                                                  appUserMappedProjectModel
                                                      ?.mappingDetailList
                                                      ?.map(
                                                (val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val.projectname,
                                                    child: Text(
                                                        val.projectname ?? ''),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    refWatch.value
                                                            ?.selectProjectDropDownValue =
                                                        val.toString();
                                                  },
                                                );
                                              },
                                            ),

                                            const SizedBox(height: 25),

                                            // Access Department DropDown

                                            DropDownWidget(
                                              hintText: refWatch.value
                                                  ?.userAccessDropDownValue,
                                              dropDownTitle:
                                                  'Please choose your work flow',
                                              dropDownValue: refWatch.value
                                                      ?.userAccessDropDownValue ??
                                                  '',
                                              dropDownItem:
                                                  userdata?.useraccess == "UNIT"
                                                      ? refWatch
                                                          .value?.unitAccess
                                                          ?.map(
                                                          (val) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: val,
                                                              child: Text(val),
                                                            );
                                                          },
                                                        ).toList()
                                                      : refWatch
                                                          .value?.workShopAccess
                                                          ?.map(
                                                          (val) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: val,
                                                              child: Text(val),
                                                            );
                                                          },
                                                        ).toList(),
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    refWatch.value
                                                            ?.userAccessDropDownValue =
                                                        val.toString();
                                                  },
                                                );
                                              },
                                            ),
                                          ]),
                                        } else if (commonApiResponseModel
                                                ?.status ==
                                            'false') ...{
                                          UserNotLocationPremise(
                                            commonApiResponseModel:
                                                commonApiResponseModel
                                                        ?.message ??
                                                    '',
                                          ),
                                        }
                                      }
                                    ],
                                  );
                                });
                          }),
                        ),
                      }
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.workFlowController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        workFlowResult = scanData;
      });
    });

    log(workFlowResult.toString(), name: 'workFlowResult');
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
    workFlowController?.dispose();
    super.dispose();
  }
}

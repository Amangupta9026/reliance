import 'dart:developer';

import '../../api_service/model/qr_inventory_detail_model.dart';
import '../../riverpod/home_screen_notifier.dart';
import '../../utils/file_collection.dart';

class SearchInventoryDetails extends StatelessWidget {
  const SearchInventoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer(builder: (context, ref, child) {
          return FutureBuilder(
              future: ref
                  .read(homeScreenNotifierProvider.notifier)
                  .apiQRInventoryDetail(context),
              builder: (context, snapshot) {
                final (qrInventoryDetailModel, commonApiResponseModel) =
                    snapshot.data ?? (null, null);
                if (!snapshot.hasData) {
                  log('No Data');
                }
                return SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const AppBarReusubility(
                          title: 'Inventory Details', isBackButton: true),
                      
                      if (commonApiResponseModel?.status == 'true') ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 60),
                          child: columnData(
                              qrInventoryDetailModel, commonApiResponseModel),
                        ),
                      } else if (commonApiResponseModel?.status == 'false') ...{
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  location,
                                  width: 150,
                                ),
                                const SizedBox(height: 25),
                                Center(
                                  child: Text(
                                    commonApiResponseModel?.message ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ))
                      }
                    ],
                  )),
                );
              });
        }),
      ),
    );
  }

  Widget columnData(QRInventoryDetailModel? qrInventoryDetailModel,
      CommonApiResponseModel? commonApiResponseModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (qrInventoryDetailModel != null &&
            qrInventoryDetailModel.status == 'false') ...{
          Center(
            child: Text(
              qrInventoryDetailModel.message ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        } else if (qrInventoryDetailModel != null &&
            qrInventoryDetailModel.status == 'true') ...{
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row('Plant Name',
                  qrInventoryDetailModel.inventoryItemDetail?.plantname ?? ''),
              const Divider(height: 10, color: secondaryColor),
              row('Unit Name',
                  qrInventoryDetailModel.inventoryItemDetail?.unitname ?? ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Sub Unit Name',
                  qrInventoryDetailModel.inventoryItemDetail?.subunitname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Sub Section Name',
                  qrInventoryDetailModel.inventoryItemDetail?.susectionname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Category Name',
                  qrInventoryDetailModel.inventoryItemDetail?.categoryname ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'RIL Inventory ID',
                  qrInventoryDetailModel.inventoryItemDetail?.rilInventoryId ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Make',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryMake ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Name',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryName ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Description',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryDesc ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Unit',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryUnit
                          .toString() ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Weight',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryWeight
                          .toString() ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Length, Width, Height',
                  qrInventoryDetailModel.inventoryItemDetail?.inventoryLwh ??
                      ''),
              const Divider(height: 10, color: secondaryColor),
              row(
                  'Inventory Date',
                  qrInventoryDetailModel
                          .inventoryItemDetail?.inventoryPurDate ??
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
}

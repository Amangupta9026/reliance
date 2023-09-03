class QRInventoryDetailModel {
  String? status;
  String? message;
  InventoryItemDetail? inventoryItemDetail;
  String? responsecode;
  String? datetimestamp;

  QRInventoryDetailModel(
      {this.status,
      this.message,
      this.inventoryItemDetail,
      this.responsecode,
      this.datetimestamp});

  QRInventoryDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    inventoryItemDetail = json['inventory_item_detail'] != null
        ? InventoryItemDetail.fromJson(json['inventory_item_detail'])
        : null;
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (inventoryItemDetail != null) {
      data['inventory_item_detail'] = inventoryItemDetail!.toJson();
    }
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}

class InventoryItemDetail {
  int? plantid;
  String? plantname;
  int? unitid;
  String? unitname;
  int? subunitid;
  String? subunitname;
  int? susectionid;
  String? susectionname;
  int? categoryid;
  String? categoryname;
  int? inventoryId;
  String? rilInventoryId;
  String? inventoryMake;
  String? inventoryName;
  String? inventoryDesc;
  int? inventoryUnit;
  num? inventoryWeight;
  String? inventoryLwh;
  String? inventoryPurDate;

  InventoryItemDetail(
      {this.plantid,
      this.plantname,
      this.unitid,
      this.unitname,
      this.subunitid,
      this.subunitname,
      this.susectionid,
      this.susectionname,
      this.categoryid,
      this.categoryname,
      this.inventoryId,
      this.rilInventoryId,
      this.inventoryMake,
      this.inventoryName,
      this.inventoryDesc,
      this.inventoryUnit,
      this.inventoryWeight,
      this.inventoryLwh,
      this.inventoryPurDate});

  InventoryItemDetail.fromJson(Map<String, dynamic> json) {
    plantid = json['plantid'];
    plantname = json['plantname'];
    unitid = json['unitid'];
    unitname = json['unitname'];
    subunitid = json['subunitid'];
    subunitname = json['subunitname'];
    susectionid = json['susectionid'];
    susectionname = json['susectionname'];
    categoryid = json['categoryid'];
    categoryname = json['categoryname'];
    inventoryId = json['inventory_id'];
    rilInventoryId = json['ril_inventory_id'];
    inventoryMake = json['inventory_make'];
    inventoryName = json['inventory_name'];
    inventoryDesc = json['inventory_desc'];
    inventoryUnit = json['inventory_unit'];
    inventoryWeight = json['inventory_weight'];
    inventoryLwh = json['inventory_lwh'];
    inventoryPurDate = json['inventory_pur_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantid'] = plantid;
    data['plantname'] = plantname;
    data['unitid'] = unitid;
    data['unitname'] = unitname;
    data['subunitid'] = subunitid;
    data['subunitname'] = subunitname;
    data['susectionid'] = susectionid;
    data['susectionname'] = susectionname;
    data['categoryid'] = categoryid;
    data['categoryname'] = categoryname;
    data['inventory_id'] = inventoryId;
    data['ril_inventory_id'] = rilInventoryId;
    data['inventory_make'] = inventoryMake;
    data['inventory_name'] = inventoryName;
    data['inventory_desc'] = inventoryDesc;
    data['inventory_unit'] = inventoryUnit;
    data['inventory_weight'] = inventoryWeight;
    data['inventory_lwh'] = inventoryLwh;
    data['inventory_pur_date'] = inventoryPurDate;
    return data;
  }
}

class GetCurrentAppVersionModel {
  String? status;
  String? message;
  String? currentVersion;
  String? responsecode;
  String? datetimestamp;

  GetCurrentAppVersionModel(
      {this.status,
      this.message,
      this.currentVersion,
      this.responsecode,
      this.datetimestamp});

  GetCurrentAppVersionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentVersion = json['current_version'];
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['current_version'] = currentVersion;
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}

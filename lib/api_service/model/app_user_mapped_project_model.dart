class AppUserMappedProjectModel {
  String? status;
  String? message;
  List<MappingDetailList>? mappingDetailList;
  String? responsecode;
  String? datetimestamp;

  AppUserMappedProjectModel(
      {this.status,
      this.message,
      this.mappingDetailList,
      this.responsecode,
      this.datetimestamp});

  AppUserMappedProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['mapping_detail_list'] != null) {
      mappingDetailList = <MappingDetailList>[];
      json['mapping_detail_list'].forEach((v) {
        mappingDetailList!.add(MappingDetailList.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (mappingDetailList != null) {
      data['mapping_detail_list'] =
          mappingDetailList!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}

class MappingDetailList {
  int? mappingid;
  int? plantid;
  int? projectid;
  String? projectname;
  int? appuserid;
  String? startdate;
  String? enddate;

  MappingDetailList(
      {this.mappingid,
      this.plantid,
      this.projectid,
      this.projectname,
      this.appuserid,
      this.startdate,
      this.enddate});

  MappingDetailList.fromJson(Map<String, dynamic> json) {
    mappingid = json['mappingid'];
    plantid = json['plantid'];
    projectid = json['projectid'];
    projectname = json['projectname'];
    appuserid = json['appuserid'];
    startdate = json['startdate'];
    enddate = json['enddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mappingid'] = mappingid;
    data['plantid'] = plantid;
    data['projectid'] = projectid;
    data['projectname'] = projectname;
    data['appuserid'] = appuserid;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    return data;
  }
}

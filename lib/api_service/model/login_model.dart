class LoginModel {
  String? status;
  String? message;
  String? datetimestamp;
  String? responsecode;
  UserDetail? userDetail;

  LoginModel(
      {this.status,
      this.message,
      this.datetimestamp,
      this.responsecode,
      this.userDetail});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    if (userDetail != null) {
      data['user_detail'] = userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  int? userid;
  String? firstname;
  String? lastname;
  String? email;
  String? clientKey;
  String? mobileno;
  int? plantid;
  String? plantname;
  String? useraccess;
  int? unitid;
  String? unitname;
  int? workshopid;
  String? workshopname;
  String? department;
  String? employeeid;
  String? status;
  String? authToken;

  UserDetail(
      {this.userid,
      this.firstname,
      this.lastname,
      this.email,
      this.clientKey,
      this.mobileno,
      this.plantid,
      this.plantname,
      this.useraccess,
      this.unitid,
      this.unitname,
      this.workshopid,
      this.workshopname,
      this.department,
      this.employeeid,
      this.status,
      this.authToken});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    clientKey = json['client_key'];
    mobileno = json['mobileno'];
    plantid = json['plantid'];
    plantname = json['plantname'];
    useraccess = json['useraccess'];
    unitid = json['unitid'];
    unitname = json['unitname'];
    workshopid = json['workshopid'];
    workshopname = json['workshopname'];
    department = json['department'];
    employeeid = json['employeeid'];
    status = json['status'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['client_key'] = clientKey;
    data['mobileno'] = mobileno;
    data['plantid'] = plantid;
    data['plantname'] = plantname;
    data['useraccess'] = useraccess;
    data['unitid'] = unitid;
    data['unitname'] = unitname;
    data['workshopid'] = workshopid;
    data['workshopname'] = workshopname;
    data['department'] = department;
    data['employeeid'] = employeeid;
    data['status'] = status;
    data['auth_token'] = authToken;
    return data;
  }
}

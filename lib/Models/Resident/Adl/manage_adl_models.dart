class Detail {
  String? title;
  String? id;
  List<String>? statusIds;
  List<Status>? statuses;
  Status? selectedStatus;

  Detail({this.id, this.title, this.statusIds, this.selectedStatus});

  Detail.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.title = map['Title'];
    this.statusIds = [...map['statusId']];
    this.statuses = [];
  }
}

class Status {
  String? title;
  String? id;
  String? remarks;

  Status({
    this.title,
    this.id,
    this.remarks,
  });

  Status.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.title = map['Title'];
  }
}

class SelectedHeader {
  String? header;
  String? headerId;
  List<Detail>? selectedDetails;

  SelectedHeader({this.header, this.headerId, this.selectedDetails});
}

class AdlRecordInfo {
  String? headerName;
  String? headerId;
  String? detailsId;
  String? statusId;
  String? remarks;
  String? addedBy;

  AdlRecordInfo({
    this.headerName,
    this.headerId,
    this.statusId,
    this.detailsId,
    this.remarks,
    this.addedBy,
  });

  AdlRecordInfo.fromMap(Map<dynamic, dynamic> map) {
    this.headerId = map['headerId'];
    this.detailsId = map['detailId'];
    this.statusId = map['statusId'];
    this.remarks = map['remarks'];
    this.addedBy = map['addedBy'];
    this.headerName = map['headerName'];
  }
}

class AdlWithHeader {
  String? headerId;
  String? headerName;
  List<AdlRecordInfo>? list;

  AdlWithHeader({this.headerId, this.list, this.headerName});
}

class SavedAdlRecord {
  String? time;
  List<AdlWithHeader>? records = [];

  SavedAdlRecord({
    this.time,
    this.records,
  });
}

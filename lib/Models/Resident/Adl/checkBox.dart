class AdlCheckBox {
  String? id;
  String? title;
  List<String>? statusIds;
  bool? isSelected;

  AdlCheckBox({this.id, this.title, this.statusIds, this.isSelected});

  AdlCheckBox.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.title = map['Title'];
    this.statusIds = [...map['statusId']];
    this.isSelected = false;
  }
}

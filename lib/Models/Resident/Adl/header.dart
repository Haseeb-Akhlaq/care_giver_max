class Header {
  String? id;
  String? title;

  Header({this.id, this.title});

  Header.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.title = map['Title'];
  }
}

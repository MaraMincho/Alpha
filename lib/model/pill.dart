class Pill {
  int? id;
  String? pillClass;
  String? shape;
  String? company;
  String? name;
  Image? image;
  bool? bookMarking;

  Pill(
      {this.id,
        this.pillClass,
        this.shape,
        this.company,
        this.name,
        this.image,
        this.bookMarking});

  Pill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pillClass = json['class'];
    shape = json['shape'];
    company = json['company'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    bookMarking = json['bookMarking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pillClass'] = this.pillClass;
    data['shape'] = this.shape;
    data['company'] = this.company;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['bookMarking'] = this.bookMarking;
    return data;
  }
}

class Image {
  String? type;
  List<int>? data;

  Image({this.type, this.data});

  Image.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}

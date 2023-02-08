class Pill {


  static final Pill instance = Pill(
    image: Image(data: [0], type: "buffer")
  );
  int? id;
  String? pillClass;
  String? form;
  String? company;
  String? name;
  Image? image;
  bool? bookMarking;
  Pill(
      {this.id,
        this.pillClass,
        this.form,
        this.company,
        this.name,
        this.image,
        this.bookMarking});

  Pill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pillClass = json['class'];
    form = json['form'];
    company = json['company'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    bookMarking = json['bookMarking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pillClass'] = this.pillClass;
    data['form'] = this.form;
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

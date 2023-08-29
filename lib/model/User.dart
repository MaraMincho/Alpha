class User {
  String? token;

  User({ this.token, });

  User.fromJson(Map<String, dynamic> json) {
    token = json['nick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick'] = this.token;
    return data;
  }
}

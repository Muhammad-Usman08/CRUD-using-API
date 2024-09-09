class ApiModel {
  String? title;
  String? subtitle;
  String? sId;

  ApiModel({this.title, this.subtitle, this.sId});

  ApiModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['_id'] = this.sId;
    return data;
  }
}

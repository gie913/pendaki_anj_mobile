class ImageResponse {
  bool? success;
  String? message;
  Data? data;

  ImageResponse({this.success, this.message, this.data});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? url;
  String? fileName;
  String? fileId;

  Data({this.url, this.fileName, this.fileId});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fileName = json['file_name'];
    fileId = json['file_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['file_name'] = this.fileName;
    data['file_id'] = this.fileId;
    return data;
  }
}
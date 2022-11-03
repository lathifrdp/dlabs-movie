class PostResponse {
  String? status;
  String? data;
  String? info;

  PostResponse({
    this.status,
    this.data,
    this.info,
  });
  PostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    data = json['data']?.toString();
    info = json['info']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    data['info'] = info;
    return data;
  }
}

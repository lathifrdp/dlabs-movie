import 'dart:io';

class MovieViewModel {
  int? size;
  int? page;
  String? title;
  String? description;
  File? poster;

  MovieViewModel(
      {this.size, this.page, this.title, this.description, this.poster});

  MovieViewModel.fromJson(Map<String, dynamic> json) {
    size = json["size"];
    page = json["page"];
    title = json["title"];
    description = json["description"];
    poster = json["poster"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['page'] = page;
    data['title'] = title;
    data['description'] = description;
    data['poster'] = poster;
    return data;
  }

  Map<String, dynamic> toJsonPaging() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['page'] = page;
    return data;
  }
}

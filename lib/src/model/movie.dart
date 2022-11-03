class Movie {
  int? id;
  String? title;
  String? description;
  String? poster;
  String? createdDate;

  Movie({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.createdDate,
  });
  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    poster = json['poster']?.toString();
    createdDate = json['created_date']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['poster'] = poster;
    data['created_date'] = createdDate;
    return data;
  }
}

class MovieResponse {
  String? status;
  List<Movie>? data;
  String? info;

  MovieResponse({
    this.status,
    this.data,
    this.info,
  });
  MovieResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <Movie>[];
      v.forEach((v) {
        arr0.add(Movie.fromJson(v));
      });
      data = arr0;
    }
    info = json['info']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v.toJson());
      }
      data['data'] = arr0;
    }
    data['info'] = info;
    return data;
  }
}

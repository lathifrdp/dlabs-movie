import 'package:dio/dio.dart';
import 'package:dlabs_movie/src/helper/constant.dart';
import 'package:dlabs_movie/src/model/movie.dart';
import 'package:dlabs_movie/src/model/movie_viewmodel.dart';
import 'package:dlabs_movie/src/model/post_response.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class MovieApi {
  Dio dio = Dio();
  late Response response;

  //Start: List Movie
  Future<MovieResponse> getMovie(MovieViewModel viewModel) async {
    try {
      response = await dio.get(
        "${baseUrl}movie",
        queryParameters: viewModel.toJsonPaging(),
      );
      var responseData = response.data;
      MovieResponse result = MovieResponse.fromJson(responseData);
      return result;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 500) {
          throw errorStatusCode500;
        }
        if (statusCode == 401) {
          throw errorAkses;
        }
        throw errorStatusCode;
      }
      throw errorKoneksi;
    }
  }
  //End: List Movie

  //Start: Create Movie
  Future<PostResponse> createMovie(MovieViewModel viewModel) async {
    try {
      if (viewModel.poster == null) {
        FormData formData = FormData.fromMap(
            {"title": viewModel.title, "description": viewModel.description});
        response = await dio.post("${baseUrl}movie", data: formData);
        var responseData = response.data;
        PostResponse result = PostResponse.fromJson(responseData);
        return result;
      } else {
        var fileName = p.basename(viewModel.poster!.path);
        FormData formData = FormData.fromMap({
          "title": viewModel.title,
          "description": viewModel.description,
          "poster": await MultipartFile.fromFile(viewModel.poster!.path,
              filename: fileName)
        });

        response = await dio.post(
          "${baseUrl}movie",
          data: formData,
        );
        var responseData = response.data;
        PostResponse result = PostResponse.fromJson(responseData);
        return result;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 500) {
          throw errorStatusCode500;
        }
        if (statusCode == 401) {
          throw errorAkses;
        }
        throw errorStatusCode;
      }
      throw errorKoneksi;
    }
  }
  //END: Create Movie
}

part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

//Start: Movie List
class GetMovieListSuccess extends MovieState {
  final MovieResponse list;
  GetMovieListSuccess(this.list);
}

class GetMovieListError extends MovieState {
  final String? errorMessage;
  GetMovieListError({this.errorMessage});
}

class GetMovieListWaiting extends MovieState {}
//End: Movie List

//START: Create Movie
class CreateMovieSuccess extends MovieState {
  final PostResponse response;
  CreateMovieSuccess(this.response);
}

class CreateMovieError extends MovieState {
  final String? errorMessage;
  CreateMovieError({this.errorMessage});
}

class CreateMovieWaiting extends MovieState {}
//End: Create Movie
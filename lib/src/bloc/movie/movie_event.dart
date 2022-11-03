part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetMovieRequest extends MovieEvent {
  final MovieViewModel viewModel;
  GetMovieRequest({required this.viewModel});
}

class CreateMovieRequest extends MovieEvent {
  final MovieViewModel viewModel;
  CreateMovieRequest({required this.viewModel});
}

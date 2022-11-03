import 'package:bloc/bloc.dart';
import 'package:dlabs_movie/src/api/movie_api.dart';
import 'package:dlabs_movie/src/model/movie.dart';
import 'package:dlabs_movie/src/model/movie_viewmodel.dart';
import 'package:dlabs_movie/src/model/post_response.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<GetMovieRequest>((event, emit) async {
      await _getMovieList(event.viewModel, emit);
    });
    on<CreateMovieRequest>((event, emit) async {
      await _createMovie(event.viewModel, emit);
    });
  }
}

Future<void> _getMovieList(
    MovieViewModel viewModel, Emitter<MovieState> emit) async {
  MovieApi api = MovieApi();
  emit(GetMovieListWaiting());
  try {
    MovieResponse data = await api.getMovie(viewModel);
    emit(GetMovieListSuccess(data));
  } catch (ex) {
    emit(GetMovieListError(errorMessage: ex.toString()));
  }
}

Future<void> _createMovie(
    MovieViewModel viewModel, Emitter<MovieState> emit) async {
  MovieApi api = MovieApi();
  emit(CreateMovieWaiting());
  try {
    PostResponse data = await api.createMovie(viewModel);
    emit(CreateMovieSuccess(data));
  } catch (ex) {
    emit(CreateMovieError(errorMessage: ex.toString()));
  }
}

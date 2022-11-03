// ignore_for_file: avoid_print

import 'package:dlabs_movie/src/bloc/movie/movie_bloc.dart';
import 'package:dlabs_movie/src/helper/date_formatter.dart';
import 'package:dlabs_movie/src/helper/theme_colors.dart';
import 'package:dlabs_movie/src/model/movie.dart';
import 'package:dlabs_movie/src/model/movie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMoviePage extends StatefulWidget {
  const ListMoviePage({Key? key}) : super(key: key);

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  MovieResponse response = MovieResponse();
  MovieBloc movieBloc = MovieBloc();

  @override
  void initState() {
    movieBloc = BlocProvider.of<MovieBloc>(context);
    MovieViewModel viewModel = MovieViewModel();
    viewModel.page = 1;
    viewModel.size = 100;
    movieBloc.add(GetMovieRequest(viewModel: viewModel));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: hijauTua,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.movie,
                        size: 50,
                        color: whiteColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Dlabs Movie",
                        style: TextStyle(color: whiteColor, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocListener(
                    bloc: movieBloc,
                    listener: (context, state) {
                      if (state is GetMovieListSuccess) {
                        response = state.list;
                      }
                      if (state is GetMovieListError) {
                        print(state.errorMessage);
                      }
                    },
                    child: BlocBuilder(
                      bloc: movieBloc,
                      builder: (context, state) {
                        if (state is GetMovieListWaiting) {
                          return Center(
                            child: CircularProgressIndicator(color: whiteColor),
                          );
                        }
                        if (state is GetMovieListError) {
                          return Center(
                            child: Text("${state.errorMessage}"),
                          );
                        }
                        if (state is GetMovieListSuccess) {
                          return response.data != null
                              ? Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: response.data!.length,
                                      itemBuilder: (ctx, idx) {
                                        return content(response.data![idx]);
                                      }),
                                )
                              : Center(
                                  child: Text(
                                    "Tidak ada data",
                                    style: TextStyle(color: grayColor70),
                                  ),
                                );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(Movie e) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              e.poster == null
                  ? "https://placehold.jp/408080/ffffff/150x150.png?text=Movie"
                  : "${e.poster}",
              fit: BoxFit.cover,
              width: 80,
              height: 100,
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${e.title}",
                style:
                    TextStyle(color: grayColor80, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "${e.description}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: grayColor80, fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(formatDateNullable(e.createdDate),
                  style: TextStyle(color: successColor60, fontSize: 12))
            ],
          ),
        ),
      ]),
    );
  }
}

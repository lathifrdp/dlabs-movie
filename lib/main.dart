import 'package:dlabs_movie/src/bloc/movie/movie_bloc.dart';
import 'package:dlabs_movie/src/ui/create_movie_page.dart';
import 'package:dlabs_movie/src/ui/detail_movie_page.dart';
import 'package:dlabs_movie/src/ui/list_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const InitApp()));
}

class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (BuildContext context) => MovieBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark)),
        ),
        routes: {
          '/': (context) => const ListMoviePage(),
          '/detail-movie': (context) => const DetailMoviePage(),
          '/create-movie': (context) => const CreateMoviePage(),
        },
      ),
    );
  }
}

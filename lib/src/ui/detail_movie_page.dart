import 'package:dlabs_movie/src/helper/date_formatter.dart';
import 'package:dlabs_movie/src/helper/theme_colors.dart';
import 'package:dlabs_movie/src/model/movie.dart';
import 'package:flutter/material.dart';

class DetailMoviePage extends StatelessWidget {
  const DetailMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Detail Film',
          style: TextStyle(color: putih, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 600,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(80)),
              child: Image.network(
                arguments.poster == null
                    ? "https://placehold.jp/408080/ffffff/500x500.png?text=Movie"
                    : arguments.poster!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          MediaQuery.removePadding(
            context: context,
            child: Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: hijauMuda,
                          maxRadius: 6,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Film',
                          style: TextStyle(color: abuTua, fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${arguments.title}",
                      style: TextStyle(
                          color: grayColor80, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      formatDateNullable(arguments.createdDate),
                      style: TextStyle(color: grayColor70, fontSize: 12),
                    ),
                    Divider(
                      color: grayColor50,
                    ),
                    Text(
                      "${arguments.description}",
                      style: TextStyle(color: grayColor70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

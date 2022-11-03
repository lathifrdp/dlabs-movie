import 'dart:io';

import 'package:dlabs_movie/src/bloc/movie/movie_bloc.dart';
import 'package:dlabs_movie/src/helper/theme_colors.dart';
import 'package:dlabs_movie/src/model/movie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CreateMoviePage extends StatefulWidget {
  const CreateMoviePage({Key? key}) : super(key: key);

  @override
  State<CreateMoviePage> createState() => _CreateMoviePageState();
}

class _CreateMoviePageState extends State<CreateMoviePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  bool isDescriptionError = false;
  bool isTitleError = false;
  File? _image;
  final picker = ImagePicker();
  MovieBloc movieBloc = MovieBloc();

  handlePost() {
    MovieViewModel viewModel = MovieViewModel(
      title: controllerTitle.text.toString(),
      description: controllerDescription.text,
      poster: _image,
    );
    movieBloc.add(CreateMovieRequest(viewModel: viewModel));
  }

  @override
  Widget build(BuildContext context) {
    movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: putih,
        iconTheme: IconThemeData(
          color: grayColor80,
        ),
        title: Text(
          'Tambah',
          style: TextStyle(color: grayColor80, fontSize: 16),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: putih,
        child: BlocListener(
          bloc: movieBloc,
          listener: (context, state) {
            if (state is CreateMovieSuccess) {
              Fluttertoast.showToast(msg: "Berhasil menambah film");
              Navigator.pushReplacementNamed(context, "/");
            }
            if (state is CreateMovieError) {
              Fluttertoast.showToast(msg: "${state.errorMessage}");
            }
          },
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    form(),
                    const SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          handlePost();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                        decoration: BoxDecoration(
                            color: hijauTua,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: putih),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Judul Film",
              style: TextStyle(
                  color: grayColor80,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            maxLines: 1,
            controller: controllerTitle,
            validator: (value) {
              if (value!.isEmpty) {
                isTitleError = true;
                return "Judul tidak boleh kosong";
              }
              return null;
            },
            onChanged: (value) {
              if (isTitleError) {
                isTitleError = false;
                _formKey.currentState!.validate();
              }
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hijauTua, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(16),
                hintText: "Contoh: Keluarga Cemara",
                hintStyle: TextStyle(color: grayColor50, fontSize: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Deskripsi Film",
              style: TextStyle(
                  color: grayColor80,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            maxLines: 5,
            controller: controllerDescription,
            validator: (value) {
              if (value!.isEmpty) {
                isDescriptionError = true;
                return "Deskripsi film tidak boleh kosong";
              }
              return null;
            },
            onChanged: (value) {
              if (isDescriptionError) {
                isDescriptionError = false;
                _formKey.currentState!.validate();
              }
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hijauTua, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(16),
                hintText: "Tulis deskripsi film disini ...",
                hintStyle: TextStyle(color: grayColor50, fontSize: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Poster",
              style: TextStyle(
                  color: grayColor80,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          _image == null
              ? Container()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    scale: 3,
                  )),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  decoration: BoxDecoration(
                      color: putih,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: grayColor30)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload_file_rounded,
                        color: grayColor60,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Upload',
                        style: TextStyle(fontSize: 12, color: grayColor70),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'File foto',
                style: TextStyle(fontSize: 12, color: grayColor70),
              )
            ],
          )
        ],
      ),
    );
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      _image = null;
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      _image = null;
    }
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';

import 'api.dart';
import 'blocs/videos_bloc.dart';
import 'screens/home.dart';

void main() {
  Api api = Api();
  api.search("naruto");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: VideosBloc(),
        child: BlocProvider(
          bloc: FavoriteBloc(),
          child: MaterialApp(
            title: 'FlutterTube',
            home: Home(),
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}

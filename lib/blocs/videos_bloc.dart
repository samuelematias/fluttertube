import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '../api.dart';
import '../models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos;

  final StreamController _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    videos = await api.search(search);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}

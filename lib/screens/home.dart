import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/favorite_bloc.dart';
import '../blocs/videos_bloc.dart';
import '../delegates/data_search.dart';
import '../models/video.dart';
import '../widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videosBloc = BlocProvider.of<VideosBloc>(context);
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 100.0,
          child: Image.asset("images/youtube-logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        centerTitle: false,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: favoriteBloc.outFav,
              initialData: {},
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else
                  return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) videosBloc.inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  videosBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          else
            return Container();
        },
      ),
    );
  }
}

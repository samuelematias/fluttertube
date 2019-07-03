import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/videos_bloc.dart';
import '../delegates/data_search.dart';
import '../widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text("0"),
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
              if (result != null)
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          else
            return Container();
        },
      ),
    );
  }
}

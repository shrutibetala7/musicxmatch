// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicxmatch/bloc/music_bloc.dart';
import 'package:musicxmatch/bloc/music_events.dart';
import 'package:musicxmatch/musicRepo.dart';

import 'bloc/music_state.dart';
import 'musicModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetBloc()),
        BlocProvider(create: (context) => MusicBloc())
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicBloc = BlocProvider.of<MusicBloc>(context);

    return Center(
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (BuildContext context, state) {
          if (state is InternetGainedState) {
            musicBloc.add(MusicSearchedEvent());

            return BlocBuilder<MusicBloc, MusicState>(
                builder: (BuildContext context, state) {
              if (state is MusicDetailsState) {
                return MusicDetails();
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Trending',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                body: FutureBuilder<MusicX>(
                    future: MusicRepo().getMusic(),
                    builder:
                        (BuildContext context, AsyncSnapshot<MusicX> snapshot) {
                      if (snapshot.hasData && state is MusicSearchedState) {
                        MusicX _musicx = snapshot.requireData;
                        var musicx = _musicx.message.body.trackList;

                        return ListView.builder(
                            itemCount: musicx.length,
                            itemBuilder: (BuildContext context, int index) {
                              var track = musicx[index].track;

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      child: ListTile(
                                        leading: Icon(Icons.library_music),
                                        title: Text(track.trackName),
                                        subtitle: Text(track.albumName),
                                        trailing: Text(track.artistName),
                                      ),
                                      onTap: () {
                                        musicBloc.add(MusicDetailsEvent());
                                      },
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              );
            });
          } else {
            return Text('Connection Lost');
          }
        },
      ),
    );
  }
}

class MusicDetails extends StatelessWidget {
  const MusicDetails({Key? key}) : super(key: key);

  // final int trackId;
  // // ignore: use_key_in_widget_constructors
  // const MusicDetails(this.trackId);

  @override
  Widget build(BuildContext context) {
    final musicBloc = BlocProvider.of<MusicBloc>(context);
    int trackId = 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder<String>(
                  future: MusicRepo().getMusicDetailsB(236420300),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Text("${snapshot.data}");
                  }),
              FutureBuilder<String>(
                  future: MusicRepo().getMusicDetailsC(236420300),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Column(
                      children: [
                        Text("Lyrics",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${snapshot.data}"),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              musicBloc.add(MusicSearchedEvent());
            }),
        title: Text(
          'Track Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}

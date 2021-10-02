import 'dart:convert';
import 'dart:async' show Future;
import 'dart:typed_data';
import 'package:alphabetgame/entities/alphabet.dart';
import 'package:alphabetgame/helper.dart';
import 'package:alphabetgame/widgets/page_header.dart';
import 'package:alphabetgame/widgets/tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';

Future<List<AlphabetEntity>> _fetchAlphabets() async {
  String jsonString =
      await rootBundle.loadString('assets/data/urduAlphabets.json');
  final jsonParsed = json.decode(jsonString);

  return jsonParsed
      .map<AlphabetEntity>((json) => new AlphabetEntity.fromJson(json))
      .toList();
}

class urduAlphabetsScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  urduAlphabetsScreen({
    this.title,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  _urduAlphabetsScreenState createState() => _urduAlphabetsScreenState();
}

class _urduAlphabetsScreenState extends State<urduAlphabetsScreen> {
  Future<List<AlphabetEntity>> _alphabetsFuture;
  AudioPlayer player;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _alphabetsFuture = _fetchAlphabets();
    player = AudioPlayer();
  }

  void _playAudio(String audioPath) async {
    await player.setAsset(audioPath);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PageHeader(
            title: widget.title,
            primaryColor: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
          ),
          Expanded(
            child: FutureBuilder(
              future: _alphabetsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: index % 2 == 0
                                ? const EdgeInsets.only(bottom: 20, right: 20)
                                : const EdgeInsets.only(bottom: 20, left: 20),
                            child: TileCard(
                              isActive: _selectedIndex == index,
                              title: snapshot.data[index].text,
                              textColor: getIndexColor(index),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                _playAudio(snapshot.data[index].audio);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }
}

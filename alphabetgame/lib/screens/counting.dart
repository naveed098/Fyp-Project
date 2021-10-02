import 'dart:convert';
import 'dart:async' show Future;
import 'package:alphabetgame/entities/number.dart';
import 'package:alphabetgame/helper.dart';
import 'package:alphabetgame/widgets/page_header.dart';
import 'package:alphabetgame/widgets/tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';


Future<List<NumberEntity>> _fetchNumbers() async {
  String jsonString = await rootBundle.loadString('assets/data/numbers.json');
  final jsonParsed = json.decode(jsonString);

  return jsonParsed
      .map<NumberEntity>((json) => new NumberEntity.fromJson(json))
      .toList();
}

class CountingScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  CountingScreen({
    this.title,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  _CountingScreenState createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  Future<List<NumberEntity>> _numbersFuture;
 AudioPlayer player;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _numbersFuture = _fetchNumbers();
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
              future: _numbersFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: index % 2 == 0
                              ? const EdgeInsets.only(bottom: 20, left: 20)
                              : const EdgeInsets.only(bottom: 20, right: 20),
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

import 'dart:convert';
import 'dart:async' show Future;
import 'dart:ui';
import 'package:alphabetgame/Constants.dart';
import 'package:alphabetgame/entities/color.dart';
import 'package:alphabetgame/widgets/page_header.dart';
import 'package:alphabetgame/widgets/tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';


Future<List<ColorEntity>> _fetchColors() async {
  String jsonString = await rootBundle.loadString('assets/data/colors.json');
  final jsonParsed = json.decode(jsonString);

  return jsonParsed
      .map<ColorEntity>((json) => new ColorEntity.fromJson(json))
      .toList();
}

class ColorsScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  ColorsScreen({
    this.title,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  Future<List<ColorEntity>> _colorsFuture;
 AudioPlayer player;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _colorsFuture = _fetchColors();
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
              future: _colorsFuture,
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
                            title: snapshot.data[index].name,
                            textColor: snapshot.data[index].name == 'White'
                                ? kTitleTextColor
                                : Colors.white,
                            backgroundColor:
                                Color(int.parse(snapshot.data[index].code)),
                            fontSizeBase: 30,
                            fontSizeActive: 40,
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

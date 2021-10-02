import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ColorGame extends StatefulWidget {
  ColorGame({Key key}) : super(key: key);

  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  /// Map to keep track of score
  final Map<String, bool> score = {};
  
  /// Choices for game
   List<Map<String, dynamic>> choices = [
    {
      'emoji': '🍏',
      "color": Colors.green,
      "abr": "g",
    },
    {
      'emoji': '🍋',
      "color": Colors.yellow,
      "abr": "y",
    },
    {
      'emoji': '🍅',
      "color": Colors.red,
      "abr": "r",
    },
    {
      'emoji': '🍇',
      "color": Colors.purple,
      "abr": "p",
    },
    {
      'emoji': '🥥',
      "color": Colors.brown,
      "abr": "b",
    },
    {
      'emoji': '🥕',
      "color": Colors.orange,
      "abr": "o",
    },
    {
      'emoji': '🍈',
      "color": Colors.green,
      "abr": "g",
    },
    {
      'emoji': '🍉',
      "color": Colors.red,
      "abr": "r",
    },
    {
      'emoji': '🍊',
      "color": Colors.orange,
      "abr": "o",
    },
    {
      'emoji': '🍌',
      "color": Colors.yellow,
      "abr": "y",
    },
    {
      'emoji': '🍍',
      "color": Colors.yellow,
      "abr": "y",
    },
    {
      'emoji': '🥭',
      "color": Colors.orange,
      "abr": "o",
    },
    {
      'emoji': '🍎',
      "color": Colors.red,
      "abr": "r",
    },
    {
      'emoji': '🍐',
      "color": Colors.green,
      "abr": "g",
    },
    {
      'emoji': '🍑',
      "color": Colors.red[300],
      "abr": "r",
    },
    {
      'emoji': '🍒',
      "color": Colors.red,
      "abr": "r",
    },
    {
      'emoji': '🍓',
      "color": Colors.red,
      "abr": "r",
    },
    {
      'emoji': '🥝',
      "color": Colors.green,
      "abr": "g",
    },
    {
      'emoji': '🥑',
      "color": Colors.green,
      "abr": "g",
    },
  ];

  // Random seed to shuffle order of items.
  int seed = 0;
  final success = AudioPlayer();  ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    initialisePlayer();
    

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
   
  }

  @override
  Widget build(BuildContext context) {
    print(choices.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            image: DecorationImage(
              image: AssetImage("assets/bubble.png"),
            ),
          ),
          child: Center(
              child: Image.asset(
            "assets/replay.png",
            height: 40,
          )),
        ),
        onPressed: () {
          setState(() {
             _controllerCenter.stop();
            score.clear();
            seed++;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/matchPairsBackground.jpg",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 72.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 72,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Image.asset("assets/bottomMenu.png"),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Score ${score.length} / 10'),
                ),
              ),
             
                 Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirection:pi / 2, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink
              ], // manually specify the colors to be used
            ),
          ),
           Align(
          alignment: Alignment.topLeft,
          child:  Padding(
            padding: const EdgeInsets.only(left:18.0, top: 30),
            child: FloatingActionButton(
              heroTag: "backButtonMatchGame",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    image: DecorationImage(
                      image: AssetImage("assets/bubble.png"),
                    ),
                  ),
                  child: Center(
                      child: Image.asset(
                    "assets/back.png",
                    height: 40,
                  )),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
            ),
          ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 120, top: 40),
            child: Text("Match the Colors", style: TextStyle( color: Colors.pink,fontFamily: "GochiHand", fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Padding(
                padding: const EdgeInsets.only(bottom: 72.0, top: 70),
                child: SafeArea(
                  child: ListView(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(10, (index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Draggable<String>(
                                data: "${choices[index]["abr"]}*_*${choices[index]["emoji"]}",
                                child: Emoji(
                                    emoji:
                                        score[choices[index]["emoji"]] == true
                                            ? '✅'
                                            : choices[index]["emoji"]),
                                feedback: Emoji(emoji: choices[index]["emoji"]),
                                childWhenDragging: Emoji(emoji: '🌱'),
                              ),
                            );
                          }).toList()
                            ..shuffle(Random(seed * 3)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: choices.take(10)
                              .map((emoji) => _buildDragTarget(emoji))
                              .toList()
                                ..shuffle(Random(seed)),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragTarget(Map map) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: DragTarget<String>(
        builder: (BuildContext context, List<String> incoming, List rejected) {
          if (score[map["emoji"]] == true) {
            return Container(decoration: BoxDecoration(

              
              color: Colors.white,
              borderRadius: BorderRadius.circular(200)
            ),
              child: Text('Correct!'),
              alignment: Alignment.center,
              height: 80,
              width: 200,
            );
          } else {
            return Container(color: map["color"], height: 80, width: 200,);
          }
        },
        onWillAccept: (data) {
          print(data);
          print(map);
          return data.split("*_*")[0] == map["abr"];
        },
        onAccept: (data) {
          setState(() {
            
            score[data.split("*_*")[1]] = true;
            success.play();
            if(score.length == 10){
               _controllerCenter.play();
            }
          });
        },
        onLeave: (data) {},
      ),
    );
  }

  void initialisePlayer() async {
    await success.setAsset(
      'assets/Music/success.mp3',
    );

    await success.setVolume(5);
  }
    @override
  void dispose() {
    
    _controllerCenter.dispose();
    super.dispose();
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        // height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bubble.png"))),
        padding: EdgeInsets.all(10),
        child: emoji == '✅'
            ? Image.asset(
                "assets/check.png",
                height: 60,
              )
            : Text(
                emoji,
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
      ),
    );
  }
}

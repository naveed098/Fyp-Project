import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';

import 'dart:math';

import 'package:alphabetgame/Games/AlphabetBubbleGame.dart/BubbleGameWidgets/AplhabetBubble.dart';
import 'package:lottie/lottie.dart';
class AlphabetBubbleGame extends StatefulWidget {
  AlphabetBubbleGame({Key key}) : super(key: key);

  @override
  _AlphabetBubbleGameState createState() => _AlphabetBubbleGameState();
}

class _AlphabetBubbleGameState extends State<AlphabetBubbleGame> {
   bool startGame = false;
   bool initialDialogue = true;
  Key k = Key("123");
  ConfettiController _controllerCenter;

  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  void onEnd() {
    print('onEnd');

    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Game Over',
            desc: 'Try Again',
            btnCancelText: "Back",
            btnCancelOnPress: () {
             
       Navigator.pop(context);
            },
            btnOkOnPress: () {
            
        resetGame();},
            )..show();
  }

  showWonDialogue() {
   _controllerCenter.play();
   
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Congratulations!',
      desc: 'You won!',
      btnCancelText: "Back",
      showCloseIcon: false,
      btnOkText: "Restart",
      btnCancelOnPress: () {
        //dispose();
       
       Navigator.pop(context);
      },
      btnOkOnPress: () {
        
        resetGame();
      },
    )..show();
  }

  List<bool> bubbles = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<int> aphaint = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26
  ];
  List<int> randAlphabets = [];
  setAplhabets() {
    Random rnd = new Random();
    for (int i = 0; i < 26; i++) {
      if (aphaint.length == 1) {
        randAlphabets.add(aphaint[0]);
        aphaint.removeAt(0);
        continue;
      }
      int rand = rnd.nextInt(aphaint.length - 1);

      randAlphabets.add(aphaint[rand]);
      aphaint.removeAt(rand);
    }
    print(randAlphabets);
  }

  final player = AudioPlayer();
 
  Duration duration = Duration();
  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));

    setAplhabets();
    initializeMusic();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6870A1),
        floatingActionButton:initialDialogue? Container():Row(
          children: [
            SizedBox(
              width: 30,
            ),
            FloatingActionButton(
              heroTag: "AlphabetHintButton",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  image: DecorationImage(
                    image: AssetImage("assets/bubble.png"),
                  ),
                ),
                child: Center(
                    child: Image.asset(
                  "assets/alphabets/${currentIndex > 26 ? 26 : currentIndex}.png",
                  height: 40,
                )),
              ),
              onPressed: () {},
            ),
            Expanded(
              child: SizedBox(),
            ),
            FloatingActionButton(
              heroTag: "AlphabetReplyButton",
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
                resetGame();
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/appbar.jpg"),
            ),
            AnimatedPositioned(
              key: k,
              onEnd: () {
                setState(() {
                  startGame = !startGame;
                });
              },
              duration: Duration(seconds: 6),
              top: startGame ? -160 : MediaQuery.of(context).size.height - 240,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(26, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                            
                              if (currentIndex == randAlphabets[index]) {
                                print("INDEX");
                                print(index);

                                print("Current Index");
                                print(currentIndex);

                                print("Alphabet number");
                                print(randAlphabets[index]);

                                print("\n\n");
                                bubbles[index] = true;
                                print(bubbles);
                                currentIndex++;

                                if(currentIndex > 26){
                                controller.disposeTimer();
                                showWonDialogue();
                                }
                              }
                            });
                          },
                          child: AlphabetBubble(
                              randAlphabets[index], index, bubbles),
                        );
                      })),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Image.asset("assets/bottomMenu.png"),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            initialDialogue ?  Container():Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Center(
                  child: CountdownTimer(

                    controller: controller,
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if (time == null) {
                        return Text('Game over', style: TextStyle( color: Colors.red,fontFamily: "GochiHand", fontSize: 40, fontWeight: FontWeight.bold));
                      }
                      return Text('${time.sec}', style: TextStyle(color: Colors.blue[600],fontFamily: "GochiHand", fontSize: 60, fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                width: MediaQuery.of(context).size.width,
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

         
          Visibility(
          visible: initialDialogue,
          child: Stack(
            children: [
              Container(
              color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  
                  child: Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  
                  height: MediaQuery.of(context).size.height / 2.5,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    setState(() {
                                          initialDialogue = false;
                                          startGame = true;
                                        });
                  },
                  child: Lottie.network("https://assets4.lottiefiles.com/packages/lf20_T0oGsn.json", height: 220))),
              ),
               Padding(
                 padding: const EdgeInsets.only(bottom: 70.0),
                 child: Align(
                  alignment: Alignment.center,
                  child: Text("START", style: TextStyle( color: Colors.pink,fontFamily: "GochiHand", fontSize: 50, fontWeight: FontWeight.bold))),
               ),
              
            ],
          )),
           Align(
          alignment: Alignment.topLeft,
          child:  Padding(
            padding: const EdgeInsets.only(left:18.0, top: 30),
            child: FloatingActionButton(
              heroTag: "AlphabetBackButton",
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
          )
         ,
          ],
        ));
  }

  resetGame() {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    controller.start();
    // setState(() {});
    // return;
    aphaint = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26
    ];
    randAlphabets = [];
    setAplhabets();
    bubbles = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    setState(() {
      currentIndex = 1;
      startGame = !startGame;
    });
  }

  void initializeMusic() async {
    
    await player.setAsset(
      'assets/Music/alphabets_background.mp3',
    );

    await player.setVolume(5);

    await player.setLoopMode(LoopMode.one);

    await player.play();

  
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    controller.dispose();
    _controllerCenter.dispose();
    super.dispose();
  }
}
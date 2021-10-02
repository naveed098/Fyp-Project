import 'package:alphabetgame/Games/AlphabetBubbleGame.dart/AlphabetBubbleGame.dart';
import 'package:alphabetgame/Games/AlphabetBubbleGame.dart/UrduAlphabetBubbleGame.dart';
import 'package:alphabetgame/Games/MathTheColours.dart/MatchTheColorGame.dart';
import 'package:alphabetgame/screens/alphabets.dart';
import 'package:alphabetgame/screens/colors.dart';
import 'package:alphabetgame/screens/counting.dart';
import 'package:alphabetgame/screens/urduAlphabets.dart';
import 'package:alphabetgame/widgets/DashboardCard.dart';
import 'package:alphabetgame/widgets/category_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _categories = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: Colors.purple[200],
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/bubble.png"),
            child: Image.asset("assets/Stickers/flower.png"),
          ),
          title: Text(
            "Learn with Fun",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            "Exercises",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 15),
          ),
          trailing: Icon(
            Icons.arrow_downward_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ),
    DashboardCard(
      sticker: "numbers",
      title: 'Learn Counting',
      subtitle: "with Numbers",
      primaryColor: Colors.greenAccent[100],
      secondaryColor: Colors.green,
      screen: CountingScreen(
        title: '123',
        primaryColor: Colors.greenAccent[100],
        secondaryColor: Colors.green,
      ),
    ),
    DashboardCard(
      sticker: "abc",
      subtitle: "with Sound",
      title: 'Learn Alphabets',
      primaryColor: Colors.purpleAccent[100],
      secondaryColor: Colors.purple,
      screen: AlphabetsScreen(
        title: 'ABC',
        primaryColor: Colors.purpleAccent[100],
        secondaryColor: Colors.purple,
      ),
    ),
    DashboardCard(
      sticker: "urduGameSticker",
      subtitle: "with Sound",
      title: 'Learn Urdu Alphabets',
      primaryColor: Colors.blueGrey[100],
      secondaryColor: Colors.blueGrey,
      screen: urduAlphabetsScreen(
        title: 'ا ب پ',
        primaryColor: Colors.blueGrey[100],
        secondaryColor: Colors.blueGrey,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: Colors.amber,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/bubble.png"),
            child: Image.asset("assets/Stickers/birthday.png"),
          ),
          title: Text(
            "Genral",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            "Brainstorm",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 15),
          ),
          trailing: Icon(
            Icons.arrow_downward_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ),
    DashboardCard(
      sticker: "tool",
      subtitle: "with Names",
      title: 'Colors',
      primaryColor: Colors.orangeAccent[100],
      secondaryColor: Colors.orange,
      screen: ColorsScreen(
        title: 'Colors',
        primaryColor: Colors.orangeAccent[100],
        secondaryColor: Colors.orange,
      ),
    ),
    DashboardCard(
      primaryColor: Colors.cyanAccent[100],
      secondaryColor: Colors.cyan,
      screen: ColorGame(),
      sticker: "mushroom",
      subtitle: "with names",
      title: "Friuts",
    ),
    DashboardCard(
      primaryColor: Colors.deepPurpleAccent[100],
      secondaryColor: Colors.deepPurple,
      screen: ColorGame(),
      sticker: "mushroom",
      subtitle: "with names",
      title: "Animals",
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: Colors.amber,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/bubble.png"),
            child: Image.asset("assets/Stickers/birthday.png"),
          ),
          title: Text(
            "Fun Games",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            "Brainstorm",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 15),
          ),
          trailing: Icon(
            Icons.arrow_downward_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ),
    DashboardCard(
      primaryColor: Colors.blueAccent[100],
      secondaryColor: Colors.blue,
      screen: AlphabetBubbleGame(),
      sticker: "abc",
      subtitle: "Pop the Alphabets",
      title: "Bubble Mania",
    ),
    DashboardCard(
      primaryColor: Colors.deepOrangeAccent[100],
      secondaryColor: Colors.deepOrange,
      screen: UrduAlphabetBubbleGame(),
      sticker: "urduGameSticker",
      subtitle: "Pop urdu Alphabets",
      title: "Bubble Mania",
    ),
    DashboardCard(
      primaryColor: Colors.redAccent[100],
      secondaryColor: Colors.red,
      screen: ColorGame(),
      sticker: "mushroom",
      subtitle: "Match the Colours",
      title: "Fruit Splash",
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: Colors.amber,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/bubble.png"),
            child: Image.asset("assets/Stickers/birthday.png"),
          ),
          title: Text(
            "Science",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            "Brainstorm",
            style: TextStyle(
                fontFamily: "GochiHand", color: Colors.white, fontSize: 15),
          ),
          trailing: Icon(
            Icons.arrow_downward_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ),
    DashboardCard(
      primaryColor: Colors.pinkAccent[100],
      secondaryColor: Colors.pink,
      screen: ColorGame(),
      sticker: "mushroom",
      subtitle: "Scientific knowledge",
      title: "Science",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          "assets/7952759.jpg",
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50].withOpacity(0.3),
            image: DecorationImage(
              image: AssetImage('assets/images/bg-bottom.png'),
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 188.0,
                backgroundColor: Colors.grey[50].withOpacity(0.3),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images/bg-top.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(_categories),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

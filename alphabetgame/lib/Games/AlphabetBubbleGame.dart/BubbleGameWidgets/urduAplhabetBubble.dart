import 'package:flutter/widgets.dart';

class urduAplhabetBubble extends StatelessWidget {
  final int index;
  final int alphaIndex;
  final List<bool> bubbles;
  urduAplhabetBubble(this.alphaIndex, this.index, this.bubbles);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: bubbles[index] ? 0 : 70,
      width: bubbles[index] ? 0 : 70,
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        image: DecorationImage(
          image: AssetImage("assets/bubble.png"),
        ),
      ),
      child: Center(
          child: Image.asset(
        "assets/urduAlphabets/$alphaIndex.jpg",
        height: 40,
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget screen;
  final String sticker;
  DashboardCard({
    Key key,
    @required this.title,
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.screen,
    @required this.subtitle,
    @required this.sticker,
  }) : super(key: key);
  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.grey[900].withOpacity(0.2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            primaryColor,
            secondaryColor,
          ],
        ),
      ),
      height: 180.0,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Image.asset(
                    "assets/Stickers/$sticker.png",
                    height: 100,
                  ),
                ),
                ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        fontFamily: "GochiHand",
                        color: Colors.white,
                        fontSize: 30),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: TextStyle(
                        fontFamily: "GochiHand",
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  trailing: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bubble.png"),
                      ),
                    ),
                    child: InkWell(
                        onTap: () {
                          _navigate(context, screen);
                        },
                        child: Center(
                            child: Image.asset(
                          "assets/Stickers/forward.png",
                          height: 40,
                        ))),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

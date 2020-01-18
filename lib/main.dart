import 'package:flutter/material.dart';
import 'package:ui_concept/CustomIcons.dart';
import 'package:ui_concept/data.dart';
import 'dart:math';
import 'dart:developer' as developer;

void main(){
  developer.log('log me', name: 'my.app.category');
  return runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var cardAspectRatio = 12.0/16.0;
var widgetApectRatio = cardAspectRatio * 1.2;


class _MyAppState extends State<MyApp>{

  var currentPage = images.length - 1.0; 

  @override
  Widget build(BuildContext context){

    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener((){
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: CustomIcons.option,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: CustomIcons.menu,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Trending", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46.0,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0
                    ),
                  ),
                  IconButton(
                    icon: CustomIcons.optionMore,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                        child: Text(
                          "Animated",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0,),
                  Text("25+ Stories",
                    style: TextStyle(color: Colors.blueAccent)
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Favourite", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46.0,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0
                    ),
                  ),
                  IconButton(
                    icon: CustomIcons.optionMore,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                        child: Text(
                          "Latest",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0,),
                  Text("9+ stories",
                    style: TextStyle(color: Colors.blueAccent)
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,

            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 18.0, bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/images/image5.png", width: 276.0, height: 222.0, fit: BoxFit.cover),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget{
  
  var currentPage;
  var padding = 20.0;
  var verticalInsert = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context){
    return new AspectRatio(
      aspectRatio: widgetApectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height  =constraints.maxHeight;


          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInsert = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for( var i = 0; i < images.length ; i++){
            var delta = i - currentPage;
            var isOnRigth = delta > 0;

            var start = padding + max(
                                        primaryCardLeft - 
                                          horizontalInsert * -delta * (isOnRigth? 15 : 1 ), 
                                        0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInsert * max(-delta, 0.0),
              bottom: padding + verticalInsert * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0
                      )
                    ]
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(images[i], fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0
                                ),
                                child: Text(title[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: 'SF-Pro-Text-Regular'
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                                child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child: Text("Ler Depois",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
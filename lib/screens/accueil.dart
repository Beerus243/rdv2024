import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardsExample extends StatefulWidget {
  @override
  _SwipeCardsExampleState createState() => _SwipeCardsExampleState();
}

class _SwipeCardsExampleState extends State<SwipeCardsExample> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;

  final List<Map<String, dynamic>> _profiles = [
    {
      "name": "Rhema Lamar",
      "age": 25,
      "image": "assets/img/rhema.jpg",
    },
    {
      "name": "Fabrice Malanga",
      "age": 22,
      "image": "assets/img/fabrice.jpg",
    },
    {
      "name": "Melissa Malanga",
      "age": 28,
      "image": "assets/img/melissa.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();

    // Préparation des cartes
    for (var profile in _profiles) {
      _swipeItems.add(
        SwipeItem(
          content: profile,
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vous avez aimé ${profile['name']}")),
            );
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vous avez ignoré ${profile['name']}")),
            );
          },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 240, 238, 238),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 30,
          ),
          Icon(
            Icons.star_border,
            size: 30,
          ),
          Icon(
            Icons.chat_sharp,
            size: 30,
          ),
          Icon(
            Icons.person,
            size: 30,
          )
        ],
        onTap: (index) {
          //
        },
      ),
      appBar: AppBar(
        elevation: 10,
        title: Row(
          children: [
            // Logo Application
            Image.asset(
              'assets/img/logotype2.png',
              height: 30,
            ),
          ],
        ),
        actions: [
          // icon de notification
          IconButton(
            onPressed: () {
              // TODO : ajourter la naviagation
              print("Vous avez recu une notification");
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO : ajourter la naviagation
              print("Vous est un génie");
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                final profile = _swipeItems[index].content;
                return Center(
                  child: Container(
                    width: 400,
                    height: 470,
                    margin: EdgeInsets.only(bottom: 70),
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          // Image de profil
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                profile["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Détails du profil
                          Positioned(
                            bottom: 10,
                            left: 20,
                            child: Text(
                              "${profile['name']}, ${profile['age']}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Vous avez vu tous les profils !")),
                );
              },
              itemChanged: (SwipeItem item, int index) {
                print("Profil actuel : ${item.content['name']}");
              },
            ),
          ),
          // Boutons d'action (Like / Nope)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _matchEngine.currentItem?.nope();
                  },
                  child: Image.asset(
                    "assets/icon/nope.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _matchEngine.currentItem?.like();
                  },
                  child: Image.asset("assets/icon/like.png"),
                ),
                FloatingActionButton(
                    onPressed: () {
                      _matchEngine.currentItem?.superLike();
                    },
                    child: Image.asset("assets/icon/icon.png")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

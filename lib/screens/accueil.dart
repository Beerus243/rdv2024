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
      "description": "Voyageur et passionné de musique 🎶🌍",
      "details": {
        "Signe astrologique": "♎ Balance",
        "Mode de vie": "Végétarien 🌱",
        "Passions": "Voyages, Musique, Photographie 📷",
      }
    },
    {
      "name": "Fabrice Malanga",
      "age": 22,
      "image": "assets/img/fabrice.jpg",
      "description": "Passionné de sport et de tech 🚀🏋️‍♂️",
      "details": {
        "Signe astrologique": "♈ Bélier",
        "Mode de vie": "Omnivore 🍖",
        "Passions": "Sport, Programmation, Jeux Vidéo 🎮",
      }
    },
    {
      "name": "Melissa",
      "age": 25,
      "image": "assets/img/melissa.jpg",
      "description": "Passionné de sport et de tech 🚀🏋️‍♂️",
      "details": {
        "Signe astrologique": "♈ Bélier",
        "Mode de vie": "Omnivore 🍖",
        "Passions": "Sport, Programmation, Jeux Vidéo 🎮",
      }
    },
  ];

  @override
  void initState() {
    super.initState();
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
      backgroundColor: const Color.fromARGB(255, 231, 230, 230),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.pinkAccent,
        backgroundColor: const Color.fromARGB(255, 231, 230, 230),
        color: const Color.fromARGB(255, 240, 238, 238),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: const [
          Icon(Icons.person, size: 38),
          Icon(Icons.explore, size: 38),
          Icon(Icons.message, size: 38),
          Icon(Icons.shop, size: 38),
        ],
        onTap: (index) {},
      ),
      appBar: AppBar(
        elevation: 10,
        title: Row(
          children: [
            Image.asset(
              'assets/img/logotype2.png',
              height: 30,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => print("Vous avez reçu une notification"),
            icon:
                const Icon(Icons.notifications, color: Colors.white, size: 30),
          ),
          IconButton(
            onPressed: () => print("Vous êtes un génie"),
            icon: const Icon(Icons.settings, color: Colors.white, size: 30),
          ),
        ],
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 550, // Pour éviter les débordements
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final profile = _swipeItems[index].content;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            profile["image"],
                            fit: BoxFit.cover,
                            height: 600,
                            width: 600,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 10,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${profile['name']}, ${profile['age']}",
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildActionButton("assets/img/nope.png",
                                () => _matchEngine.currentItem?.nope()),
                            const SizedBox(width: 15),
                            _buildActionButton("assets/img/icon.png",
                                () => _matchEngine.currentItem?.like()),
                            const SizedBox(width: 15),
                            _buildActionButton("assets/img/star.png",
                                () => _matchEngine.currentItem?.superLike()),
                            const SizedBox(width: 15),
                            _buildActionButton("assets/img/message.png",
                                () => _matchEngine.currentItem?.like()),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Vous avez vu tous les profils !")),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: _profiles.map((profile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var entry
                          in (profile["details"] as Map<String, String>)
                              .entries)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  entry.value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String imagePath, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 5,
      child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
    );
  }
}

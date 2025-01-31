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
      "description": {
        "Signe astrologique": "♎ Balance",
        "Mode de vie": "Végétarien 🌱",
        "Passions": "Voyages, Musique, Photographie 📷",
      }
    },
    {
      "name": "Fabrice Malanga",
      "age": 22,
      "image": "assets/img/fabrice.jpg",
      "description": {
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
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 240, 238, 238),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: const [
          Icon(Icons.person, size: 30),
          Icon(Icons.star_border, size: 30),
          Icon(Icons.chat_sharp, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {},
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logotype2.png',
              height: 30,
            ),
          ],
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 550,
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final profile = _swipeItems[index].content;
                  return Stack(
                    children: [
                      // Carte avec l'image et l'élévation
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            profile["image"],
                            fit: BoxFit.cover,
                            height: 500,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      // Nom et âge
                      Positioned(
                        bottom: 70,
                        left: 20,
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
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Boutons sur l'image
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
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
            const SizedBox(height: 20),
            // Description sous la photo avec des divs colorés et élévation
            Column(
              children: _swipeItems[0]
                  .content["description"]
                  .entries
                  .map<Widget>((entry) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          entry.value,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String imagePath, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      elevation: 5, // Rétablissement de l'élévation
      child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
    );
  }
}

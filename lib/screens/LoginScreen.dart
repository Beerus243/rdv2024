import 'package:flutter/material.dart';
import 'carrousel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Implémentez ici la logique de connexion, comme la validation des identifiants
    print("Email: $email");
    print("Mot de passe: $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE73162),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/img/logo_rdv.png',
                      width: 350,
                      height: 100,
                    ),
                    // Titre
                    const Text(
                      "Connexion",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE73162),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Champ Adresse e-mail
                    TextField(
                      controller: emailController,
                      onChanged: (value) => _updateButtonState(),
                      decoration: InputDecoration(
                        labelText: "Adresse e-mail",
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFFE73162)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Champ Mot de passe
                    TextField(
                      controller: passwordController,
                      onChanged: (value) => _updateButtonState(),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFFE73162)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bouton Connexion
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarouselPage(),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE73162),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Lien Mot de passe oublié
                    TextButton(
                      onPressed: () {
                        print("Mot de passe oublié");
                      },
                      child: const Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: Color(0xFFE73162)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

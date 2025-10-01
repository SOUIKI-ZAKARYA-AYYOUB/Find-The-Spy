import 'package:find_the_spy/screens/game/choices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SpyPage extends StatefulWidget {
  final String spy;
  final List<String> players;
  late Map<String, int> points;
  final String word;
  final String field;

  SpyPage({
    required this.field,
    required this.word,
    required this.spy,
    required this.players,
    required this.points,
    super.key,
  });

  @override
  State<SpyPage> createState() => _SpyPageState();
}

class _SpyPageState extends State<SpyPage> {
  String selectedLanguage = "ar";

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  /// Load saved language from SharedPreferences
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString("selectedLanguage") ?? "ar";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 34, 1)),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            selectedLanguage == "ar"
                                ? "الصفحة الرئيسية"
                                : "Home Page",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          content: Text(
                            selectedLanguage == "ar"
                                ? "هل تريد مغادرة اللعبة والعودة إلى القائمة؟"
                                : "Do you want to leave the game and go to the menu?",
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                selectedLanguage == "ar" ? "لا" : "No",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.green,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/",
                                  (route) => false,
                                );
                              },
                              child: Text(
                                selectedLanguage == "ar" ? "تأكيد" : "Confirm",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Center(
                      child: Image.asset(
                        "assets/images/title_img.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  selectedLanguage == "ar" ? "اكشف الجاسوس" : "Unmask the Spy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(3, 3),
                      ),
                      Shadow(
                        blurRadius: 12,
                        color: Colors.cyanAccent.shade100,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 1,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(height: 100),
                Text(
                  selectedLanguage == "ar" ? "الجاسوس هو" : "The spy is",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SpyCountdown(spy: widget.spy),
              ],
            ),

            // Button
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChoicesPage(
                        word: widget.word,
                        spy: widget.spy,
                        players: widget.players,
                        points: widget.points,
                        field: widget.field,
                      ),
                    ),
                    (route) => false,
                  );
                },
                color: Colors.greenAccent.shade700,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedLanguage == "ar" ? "عرض الكلمات" : "See choices",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpyCountdown extends StatefulWidget {
  final String spy;
  const SpyCountdown({super.key, required this.spy});

  @override
  State<SpyCountdown> createState() => _SpyCountdownState();
}

class _SpyCountdownState extends State<SpyCountdown> {
  String displayText = "4";

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    List<String> sequence = ["3", "2", "1", widget.spy];
    for (int i = 0; i < sequence.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        displayText = sequence[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: displayText == widget.spy
            ? const Color.fromARGB(255, 250, 0, 0)
            : Colors.amber,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

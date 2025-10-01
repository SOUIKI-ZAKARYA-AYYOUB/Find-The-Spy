import 'package:flutter/material.dart';
import 'package:find_the_spy/screens/game/lobby.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class IntroPage extends StatefulWidget {
  final String field;
  final List<String> players;
  late Map<String, int> points;

  IntroPage({
    required this.field,
    required this.players,
    required this.points,
    super.key,
  });

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String selectedLanguage = 'ar';
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
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 34, 1)),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            selectedLanguage == 'en'
                                ? "Home Page"
                                : "الصفحة الرئيسية",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          content: Text(
                            selectedLanguage == 'en'
                                ? "Do you want to leave the game and go to the menu?"
                                : "هل تريد مغادرة اللعبة والذهاب إلى القائمة؟",
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
                                selectedLanguage == 'en' ? "No" : "لا",
                                style: TextStyle(
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
                                selectedLanguage == 'en' ? "Confirm" : "تأكيد",
                                style: TextStyle(color: Colors.black),
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
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
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
                const SizedBox(height: 30),
                Text(
                  selectedLanguage == 'en' ? "Hidden Role" : "المهمة الخفية",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: 2,
                    shadows: [
                      const Shadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(3, 3),
                      ),
                      Shadow(
                        blurRadius: 12,
                        color: Colors.cyanAccent.shade100,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 1,
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),
                Text(
                  selectedLanguage == "en"
                      ? "Field: ${widget.field}"
                      : "الحقل:${widget.field}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                    letterSpacing: 1.5,
                    shadows: [
                      const Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                      Shadow(
                        blurRadius: 10,
                        color: Colors.cyanAccent.shade100,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  selectedLanguage == "en"
                      ? "All players except one will receive the same word. Try to spot the spy!"
                      : "جميع اللاعبين ما عدا واحد سيحصلون على نفس الكلمة. حاول اكتشاف الجاسوس!",
                  textDirection: selectedLanguage == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      const Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                      Shadow(
                        blurRadius: 10,
                        color: Colors.cyanAccent.shade100,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 200),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Lobby(
                        points: widget.points,
                        word: "",
                        players: [],
                        spy: '',
                        firstTime: true,
                        field: widget.field,
                        counter: 0,
                      ),
                    ),
                    (route) => false,
                  );
                },
                color: Colors.greenAccent.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedLanguage == "en" ? "Start" : "بدأ اللعب",
                  style: TextStyle(
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

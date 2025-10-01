import 'package:find_the_spy/screens/game/round.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/screens/game/lobby.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MissionPage extends StatefulWidget {
  late int counter;
  final List<String> players;
  final bool firstTime;
  final String spy;
  final String field;
  late Map<String, int> points;
  final String name;
  final String word;
  final bool isSpy; // True if player is the spy

  MissionPage({
    required this.firstTime,
    required this.points,
    required this.field,
    required this.counter,
    required this.players,
    required this.spy,
    required this.name,
    required this.word,
    required this.isSpy,
    super.key,
  });

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  String selectedLanguage = "en";

  /// Load saved language from SharedPreferences
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString("selectedLanguage") ?? "ar";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 0, 34, 1),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 40),
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
                                  ? "هل تريد مغادرة اللعبة والذهاب إلى القائمة؟"
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
                                  selectedLanguage == "ar"
                                      ? "تأكيد"
                                      : "Confirm",
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
                    selectedLanguage == "ar" ? "المهمة" : "Mission",
                    style: TextStyle(
                      fontSize: 30,
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
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 1,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "${selectedLanguage == "ar" ? "اللاعب" : "Player"}: ${widget.name}",
                    textDirection: selectedLanguage == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),
                  widget.isSpy
                      ? Column(
                          children: [
                            Text(
                              selectedLanguage == "ar" ? "أنت" : "You are the",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              selectedLanguage == "ar" ? "الجاسوس" : "SPY",
                              textDirection: selectedLanguage == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent.shade200,
                                letterSpacing: 2,
                                shadows: const [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                  Shadow(
                                    blurRadius: 15,
                                    color: Colors.redAccent,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              selectedLanguage == "ar"
                                  ? "حاول تخمين الكلمة السرية"
                                  : "Try to guess the secret word",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              selectedLanguage == "ar"
                                  ? "أنت من بين الذين يعرفون الكلمة السرية. استخدمها بحكمة لإقناع الآخرين مع البقاء متيقظًا للجاسوس!\n\nكلمتك السرية هي:"
                                  : "You are among those who know the secret word. Use it wisely to convince others while staying alert for the spy!\n\nYour Secret Word is:",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.word,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {
                  if (widget.counter < (widget.players.length - 1)) {
                    widget.counter =
                        (widget.counter + 1) % widget.players.length;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Lobby(
                          points: widget.points,
                          word: widget.word,
                          firstTime: false,
                          counter: widget.counter,
                          field: widget.field,
                          players: widget.players,
                          spy: widget.spy,
                        ),
                      ),
                      (route) => true,
                    );
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => RoundPage(
                          points: widget.points,
                          field: widget.field,
                          players: widget.players,
                          spy: widget.spy,
                          word: widget.word,
                          counter: 0,
                        ),
                      ),
                      (route) => false,
                    );
                  }
                },
                color: Colors.greenAccent.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 120,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedLanguage == "ar" ? "تم" : "Got it",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

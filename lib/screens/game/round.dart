import 'package:find_the_spy/screens/game/round_with_vote.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/generate_a_round.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RoundPage extends StatefulWidget {
  final String word;
  final String spy;
  final List players;
  late int counter;
  late Map<String, int> points;
  final String field;

  RoundPage({
    required this.points,
    required this.field,
    required this.players,
    required this.spy,
    required this.word,
    required this.counter,
    super.key,
  });

  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  late List<Map<String, String>> round;
  String selectedLanguage = "en";

  @override
  void initState() {
    super.initState();
    round = generateRound(widget.players as List<String>);
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
                  selectedLanguage == "ar" ? "دور الأسئلة" : "Questions Role",
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
                const SizedBox(height: 200),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                    children: [
                      TextSpan(
                        text: selectedLanguage == "ar" ? "الآن، " : "Now, ",
                      ),
                      TextSpan(
                        text: round[widget.counter]["asker"],
                        style: const TextStyle(
                          color: Colors.amber, // yellow
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "ar"
                            ? " يجب أن يسأل "
                            : " should ask ",
                      ),
                      TextSpan(
                        text: round[widget.counter]["receiver"],
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "ar"
                            ? " عن الكلمة السرية."
                            : " about the secret word.",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: MaterialButton(
                onPressed: () {
                  String lastOne = round[widget.counter]["receiver"]!;
                  setState(() {
                    widget.counter++;
                    if (widget.counter == round.length) {
                      widget.counter = 0;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => RoundVotePage(
                            points: widget.points,
                            field: widget.field,
                            players: widget.players,
                            spy: widget.spy,
                            word: widget.word,
                            turn: lastOne,
                          ),
                        ),
                        (route) => false,
                      );
                    }
                  });
                },
                color: Colors.greenAccent.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedLanguage == "ar" ? "تمرير" : "Pass",
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

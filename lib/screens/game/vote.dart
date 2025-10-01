import 'package:find_the_spy/screens/game/spy.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/get_others.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class VotePage extends StatefulWidget {
  final String word;
  final String spy;
  final List players;
  late Map<String, int> points;
  final String field;

  VotePage({
    required this.points,
    required this.field,
    required this.players,
    required this.spy,
    required this.word,
    super.key,
  });

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  late List<String> others;
  int currentIndex = 0;
  String selectedLanguage = "ar";

  @override
  void initState() {
    super.initState();
    others = getOthers(
      widget.players as List<String>,
      widget.players[currentIndex % widget.players.length],
    );
    if (widget.points.isEmpty) {
      widget.points = {for (var player in widget.players) player: 0};
    }
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
                  selectedLanguage == "ar" ? "التصويت" : "Voting",
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
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 1,
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                    children: [
                      TextSpan(
                        text: selectedLanguage == "ar" ? "الآن، " : "Now, ",
                      ),
                      TextSpan(
                        text: widget
                            .players[currentIndex % widget.players.length]!,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "ar"
                            ? " اختر اللاعب الذي تعتقد أنه الجاسوس!"
                            : " choose the player you think is the Spy!",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: others.length,
                  itemBuilder: (context, index) => MaterialButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      if (others[index] == widget.spy) {
                        String player = widget.players[currentIndex];
                        widget.points[player] =
                            (widget.points[player] ?? 0) + 1;
                      }
                      currentIndex++;
                      if (currentIndex == widget.players.length) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => SpyPage(
                              field: widget.field,
                              word: widget.word,
                              spy: widget.spy,
                              players: widget.players as List<String>,
                              points: widget.points,
                            ),
                          ),
                          (route) => false,
                        );
                        return;
                      }
                      setState(() {
                        others = getOthers(
                          widget.players as List<String>,
                          widget.players[currentIndex % widget.players.length],
                        );
                      });
                    },
                    child: Text(
                      others[index],
                      textAlign: TextAlign.center,
                      textDirection: selectedLanguage == 'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
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
          ],
        ),
      ),
    );
  }
}

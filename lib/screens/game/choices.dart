import 'package:find_the_spy/screens/game/points.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/get_words.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ChoicesPage extends StatefulWidget {
  final String spy;
  final String word;
  late Map<String, int> points;
  late List<String> players;
  final String field;

  ChoicesPage({
    required this.field,
    required this.word,
    required this.spy,
    required this.points,
    required this.players,
    super.key,
  });

  @override
  State<ChoicesPage> createState() => _ChoicesPageState();
}

class _ChoicesPageState extends State<ChoicesPage> {
  late List<String> words = [];
  List<String> colors = [];
  bool choiceMade = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  String selectedLanguage = "ar";

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadWords();
  }

  /// Load saved language from SharedPreferences
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString("selectedLanguage") ?? "ar";
    });
  }

  Future<void> _loadWords() async {
    final loadedWords = await getWords(widget.field, widget.word);
    setState(() {
      words = loadedWords.map((item) => item['name'] as String).toList();
      words.shuffle();
      colors = List.filled(words.length, "blue");
      choiceMade = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (words.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 34, 1)),
        child: ListView(
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
                            Navigator.of(
                              context,
                            ).pushNamedAndRemoveUntil("/", (route) => false);
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
              selectedLanguage == "ar" ? "البحث عن الكلمة" : "Word Hunt",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black45,
                    offset: Offset(3, 3),
                  ),
                  Shadow(
                    blurRadius: 12,
                    color: Colors.cyanAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 22, color: Colors.white),
                children: [
                  TextSpan(text: selectedLanguage == "ar" ? "الآن، " : "Now, "),
                  TextSpan(
                    text: widget.spy,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: selectedLanguage == "ar"
                        ? " اختر الكلمة التي تعتقد أنها الصحيحة!"
                        : " pick the word you believe is correct!",
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 1,
              height: 2,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: words.length,
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: choiceMade
                      ? null
                      : () {
                          setState(() {
                            if (words[index] == widget.word) {
                              colors[index] = "green";
                              String player = widget.spy;
                              widget.points[player] =
                                  (widget.points[player] ?? 0) + 1;

                              _audioPlayer.play(AssetSource('sounds/win.mp3'));
                            } else {
                              colors[index] = "red";
                              colors[words.indexOf(widget.word)] = "green";

                              _audioPlayer.play(AssetSource('sounds/lose.mp3'));
                            }
                            choiceMade = true;
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PointsPage(
                                    points: widget.points,
                                    players: widget.players,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                  color: colors[index] == "blue"
                      ? Colors.lightBlue
                      : colors[index] == "green"
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  disabledColor: colors[index] == "blue"
                      ? Colors.lightBlue
                      : colors[index] == "green"
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    words[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

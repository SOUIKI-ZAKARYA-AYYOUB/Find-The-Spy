import 'package:find_the_spy/screens/game/mission.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/get_load_players.dart';
import 'package:find_the_spy/utils/get_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Lobby extends StatefulWidget {
  late bool firstTime;
  late int counter;
  late List<String> players;
  late Map<String, int> points;
  late String spy;
  late String word;
  final String field;

  Lobby({
    required this.word,
    required this.points,
    required this.firstTime,
    required this.field,
    required this.counter,
    required this.players,
    required this.spy,
    super.key,
  });

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  String selectedLanguage = 'ar';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    if (widget.firstTime && widget.players.isEmpty) _setup();
  }

  /// Load saved language from SharedPreferences
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString("selectedLanguage") ?? "ar";
    });
  }

  void _setup() async {
    List<String> loadedPlayers = await loadPlayers();
    loadedPlayers.shuffle();
    widget.spy = loadedPlayers.first;
    loadedPlayers.shuffle();
    widget.word = await getWord(widget.field);
    setState(() {
      widget.players = widget.players.isEmpty ? loadedPlayers : widget.players;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.players.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 34, 1)),
        child: Column(
          children: [
            Expanded(
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
                    selectedLanguage == "ar" ? "الردهة" : "Lobby",
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
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 1,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    selectedLanguage == "ar"
                        ? "أعط الهاتف إلى"
                        : "Give the phone to",
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.players[widget.counter],
                    textDirection: selectedLanguage == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedLanguage == "ar"
                        ? "أخفِ شاشتك عن الآخرين."
                        : "Keep your screen hidden from others.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MissionPage(
                        points: widget.points,
                        counter: widget.counter,
                        field: widget.field,
                        name: widget.players[widget.counter],
                        word: widget.word,
                        isSpy: widget.players[widget.counter] == widget.spy,
                        firstTime: false,
                        players: widget.players,
                        spy: widget.spy,
                      ),
                    ),
                  );
                },
                color: Colors.greenAccent.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 150,
                  vertical: 15,
                ),
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

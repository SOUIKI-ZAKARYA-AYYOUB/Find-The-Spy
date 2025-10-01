import 'package:find_the_spy/screens/categories.dart';
import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/get_load_players.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String selectedLanguage = "ar";
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

  /// Save selected language
  Future<void> _saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedLanguage", lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 34, 1)),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Container(
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
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  selectedLanguage == 'en' ? "Game Menu" : "قائمة اللعبة",
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
                const SizedBox(height: 60),
                Column(
                  children: [
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.greenAccent.shade400,
                        ),
                        onPressed: () async {
                          int count = await numberPlayers();

                          if (count >= 3) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesPage(players: [], points: {}),
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      selectedLanguage == "en"
                                          ? "Not Enough Players"
                                          : "عدد اللاعبين ناقص",
                                      textAlign: selectedLanguage == 'en'
                                          ? TextAlign.left
                                          : TextAlign.right,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(
                                  selectedLanguage == 'en'
                                      ? "You need at least 3 players to start the game. Please add more players before continuing."
                                      : "تحتاج إلى 3 لاعبين على الأقل لبدء اللعبة. يرجى إضافة لاعبين إضافيين قبل المتابعة",
                                  textAlign: selectedLanguage == 'en'
                                      ? TextAlign.left
                                      : TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade600,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(
                                      selectedLanguage == 'en'
                                          ? "Cancel"
                                          : "الغاء",
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        0,
                                        102,
                                        255,
                                      ),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                      Navigator.pushNamed(context, "/players");
                                    },
                                    child: Text(
                                      selectedLanguage == 'en'
                                          ? "Add Players"
                                          : "إضافة لاعبين",
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.play_circle_fill,
                          size: 24,
                          color: Colors.white,
                        ),
                        label: Text(
                          selectedLanguage == 'en'
                              ? "Start The Game"
                              : "ابدء اللعب",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.deepOrangeAccent,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/help");
                        },
                        icon: Icon(Icons.help, size: 24, color: Colors.white),
                        label: Text(
                          selectedLanguage == 'en'
                              ? "How To Play"
                              : "كيفية اللعب",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/players");
                        },
                        icon: Icon(
                          Icons.people_alt,
                          size: 24,
                          color: Colors.white,
                        ),
                        label: Text(
                          selectedLanguage == 'en' ? "Players" : "اللاعبين",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/about");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.help_outline, color: Colors.white),
                            Text(
                              selectedLanguage == 'en'
                                  ? " about the game"
                                  : "عن اللعبة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedLanguage == 'en'
                            ? "Select Language"
                            : "اختر اللغة",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: selectedLanguage,
                        isExpanded: true,
                        items: <String>['en', 'ar'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == 'en' ? 'English' : 'العربية'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                          });
                          print("Selected language: $selectedLanguage");
                          _saveLanguage(selectedLanguage);
                        },
                      ),
                    ],
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

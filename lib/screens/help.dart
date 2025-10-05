import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String selectedLanguage = "ar"; // default

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
                Container(
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
                const SizedBox(height: 30),
                Text(
                  selectedLanguage == "en"
                      ? "How to play the game"
                      : "كيفية لعب اللعبة",
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
                const SizedBox(height: 20),
                Text(
                  selectedLanguage == "en"
                      ? "In this game, players receive a secret word except for one spy who does not know it. Players take turns asking and answering questions to find out who the spy is. Use your deduction skills and have fun trying to spot the spy!"
                      : "في هذه اللعبة، يحصل اللاعبون على كلمة سرية باستثناء جاسوس واحد لا يعرفها. يتناوب اللاعبون على طرح الأسئلة والإجابة عنها لمعرفة من هو الجاسوس. استخدم مهاراتك في الاستنتاج واستمتع بمحاولة اكتشاف الجاسوس!",
                  textDirection: selectedLanguage == "en"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text.rich(
                  textDirection: selectedLanguage == "en"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "Pointing rules:\n\n"
                            : "قواعد احتساب النقاط:\n\n",

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "+1 point "
                            : "+1 نقطة ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "for the player who correctly identifies the spy\n\n"
                            : "للاعب الذي يكتشف الجاسوس بشكل صحيح\n\n",
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "+1 point "
                            : "+1 نقطة ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "for the spy who correctly guesses the secret word\n\n"
                            : "للجاسوس إذا تمكن من تخمين الكلمة السرية\n\n",
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "+0 point "
                            : "+1 نقطة ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: selectedLanguage == "en"
                            ? "for an incorrect guess"
                            : "للتخمين الخاطئ",
                      ),
                    ],
                  ),
                  textAlign: selectedLanguage == "en"
                      ? TextAlign.left
                      : TextAlign.right,
                ),
                const SizedBox(height: 150),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: SizedBox(
                width: 180,
                child: MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.greenAccent.shade400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 24, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        selectedLanguage == "en" ? "Go Back" : "الرجوع",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

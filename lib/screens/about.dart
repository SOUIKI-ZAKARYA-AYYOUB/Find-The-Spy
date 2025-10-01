import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 34, 1)),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  selectedLanguage == "en" ? "About The Game" : "عن اللعبة",
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
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    selectedLanguage == "en"
                        ? "Find The Spy is a fun and engaging social game where players "
                              "take on different roles to identify the spy in their midst. "
                              "The game encourages strategy, observation, and teamwork. "
                              "Players take turns asking questions and making guesses, "
                              "trying to uncover the spy before they sabotage the mission. "
                              "Suitable for 3 or more players, this game promises hours of "
                              "fun and excitement for friends and family alike.\n\n"
                              "Developed by: Souiki Zakarya Ayyoub"
                        : "لعبة \"اعثر على الجاسوس\" هي لعبة اجتماعية ممتعة وشيقة حيث يتقمص اللاعبون أدوارًا مختلفة لمحاولة كشف الجاسوس بينهم. تشجع اللعبة على استخدام الاستراتيجية والملاحظة والعمل الجماعي. يتناوب اللاعبون على طرح الأسئلة وتقديم التخمينات، في محاولة لاكتشاف الجاسوس قبل أن يفسد المهمة. اللعبة مناسبة لثلاثة لاعبين أو أكثر، وتعد بساعات من المتعة والإثارة للأصدقاء والعائلة على حد سواء.\n\nتم تطوير اللعبة بواسطة: سويقي زكرياء أيوب",
                    textDirection: selectedLanguage == "en"
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, size: 24),
                  label: Text(
                    selectedLanguage == "en" ? "Back to Menu" : "العودة للصفحة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

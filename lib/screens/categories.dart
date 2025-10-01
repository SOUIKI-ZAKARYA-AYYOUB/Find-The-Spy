import 'package:find_the_spy/screens/game/intro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesPage extends StatefulWidget {
  final List<String> players;
  final Map<String, int> points;

  const CategoriesPage({
    required this.players,
    required this.points,
    super.key,
  });

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String selectedLanguage = "ar"; // default
  final List<Map> categories = [
    {"en": "Fruits", "ar": "الفواكه"},
    {"en": "Buildings", "ar": "المباني"},
    {"en": "Greens", "ar": "الخضروات"},
    {"en": "Clothes", "ar": "الملابس"},
    {"en": "Jobs", "ar": "المهن"},
    {"en": "Countries", "ar": "البلدان"},
    {"en": "Animals", "ar": "الحيوانات"},
    {"en": "Computer", "ar": "الحاسوب"},
    {"en": "Tools", "ar": "الأدوات"},
  ];

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
          shrinkWrap: true,
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
              selectedLanguage == "en" ? "Choose a category" : "اختيار الصنف",
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
            Text(
              selectedLanguage == "en"
                  ? "The word will be selected from the choosed category"
                  : "سيتم اختيار الكلمة السرية من الفئة المختارة",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black45,
                    offset: Offset(2, 2),
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 200 / 300,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroPage(
                        field: categories[index][selectedLanguage],
                        players: widget.players,
                        points: widget.points,
                      ),
                    ),
                    (route) => true,
                  );
                },
                child: Card(
                  elevation: 10,
                  shadowColor: const Color.fromARGB(255, 200, 255, 0),
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.asset(
                            "assets/images/categories/${categories[index]['en'].toLowerCase()}.png",
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        categories[index][selectedLanguage],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 180,
                child: MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil("/", (route) => false);
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:find_the_spy/screens/categories.dart';
import 'package:find_the_spy/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PointsPage extends StatefulWidget {
  Map<String, int> points;
  final List<String> players;

  PointsPage({required this.points, required this.players, super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  String selectedLanguage = "ar"; // default language

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
        child: Column(
          children: [
            Expanded(
              child: ListView(
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
                    selectedLanguage == "ar"
                        ? "نقاط اللاعبين"
                        : "Players Points",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 1,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.players.length,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                        onPressed: null,
                        color: Colors.white,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              widget.players[index],
                              textDirection: selectedLanguage == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            trailing: Text(
                              "${widget.points[widget.players[index]]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            selectedLanguage == "ar" ? "تأكيد" : "Confirm",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                          content: Text(
                            selectedLanguage == "ar"
                                ? "هل أنت متأكد أنك تريد العودة إلى القائمة؟"
                                : "Are you sure you want to go to the Menu?",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                selectedLanguage == "ar" ? "إلغاء" : "Cancel",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.greenAccent,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                selectedLanguage == "ar" ? "نعم" : "Yes",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: Text(selectedLanguage == "ar" ? "القائمة" : "Menu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            selectedLanguage == "ar"
                                ? "إعادة تشغيل اللعبة"
                                : "Restart the game",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                          content: Text(
                            selectedLanguage == "ar"
                                ? "هل تريد إعادة تعيين النقاط؟\nإذا قمت بذلك سيتم إعادة نقاط جميع اللاعبين إلى 0"
                                : "Do you want to restart the scores?\nIf you do it then: All the players score will be 0",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesPage(
                                      players: widget.players,
                                      points: {},
                                    ),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                selectedLanguage == "ar"
                                    ? "إعادة التعيين"
                                    : "Restart Score",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.greenAccent,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesPage(
                                      players: widget.players,
                                      points: widget.points,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                selectedLanguage == "ar"
                                    ? "الاحتفاظ بالنقاط"
                                    : "Keep Score",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.restart_alt),
                    label: Text(
                      selectedLanguage == "ar" ? "إعادة التشغيل" : "Restart",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

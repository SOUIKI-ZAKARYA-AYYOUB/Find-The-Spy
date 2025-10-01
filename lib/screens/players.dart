import 'package:flutter/material.dart';
import 'package:find_the_spy/utils/get_load_players.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players extends StatefulWidget {
  const Players({super.key});
  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  List<String> players = [];
  String selectedLanguage = "ar"; // default

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
    loadPlayers().then((loaded) {
      setState(() {
        players = loaded;
      });
    });
    _loadLanguage();
  }

  @override
  void dispose() {
    savePlayers(players);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 34, 1)),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 30),
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
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              selectedLanguage == "en" ? "Players list" : "قائمة اللاعبين",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black45,
                    offset: Offset(2, 2),
                  ),
                  Shadow(
                    blurRadius: 10,
                    color: Colors.cyanAccent.shade100,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              selectedLanguage == "en"
                  ? "The list must contains at least 3 players"
                  : "يجب أن تحتوي القائمة على 3 لاعبين على الأقل",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black45,
                    offset: Offset(2, 2),
                  ),
                  Shadow(
                    blurRadius: 10,
                    color: Colors.cyanAccent.shade100,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 1,
              height: 2,
              color: Colors.grey,
            ),
            Text(
              players.length > 0
                  ? ""
                  : selectedLanguage == "en"
                  ? "no players"
                  : "لا يوجد لاعبين",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 167, 165, 165),
                fontSize: 30,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: players.length,
              itemBuilder: (context, index) => Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: ListTile(
                  title: Text(
                    players[index],
                    textDirection: selectedLanguage == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () async {
                      TextEditingController controller = TextEditingController(
                        text: players[index],
                      );
                      String? errorText;

                      String? newName = await showDialog<String>(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setStateDialog) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white,
                            title: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.black),
                                SizedBox(width: 10),
                                Text(
                                  selectedLanguage == "en"
                                      ? "Edit Player"
                                      : "تعديل اللاعب",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  maxLength: 12,
                                  controller: controller,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorText: errorText,
                                    hintText: selectedLanguage == "en"
                                        ? "Enter new name"
                                        : "أدخل اسم جديد",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (players.contains(value.trim()) &&
                                        value.trim() != players[index]) {
                                      setStateDialog(() {
                                        errorText = selectedLanguage == "en"
                                            ? "Player already exists!"
                                            : "!اللاعب موجود بالفعل";
                                      });
                                    } else {
                                      setStateDialog(() {
                                        errorText = null;
                                      });
                                    }
                                  },
                                ),
                                // if (errorText != null)
                                //   Padding(
                                //     padding: const EdgeInsets.only(top: 8.0),
                                //     child: Text(
                                //       errorText!,
                                //       style: TextStyle(
                                //         color: Colors.red,
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            actionsPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.redAccent,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  selectedLanguage == "en" ? "Cancel" : "الغاء",
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (controller.text.trim().isEmpty ||
                                      (players.contains(
                                            controller.text.trim(),
                                          ) &&
                                          controller.text.trim() !=
                                              players[index])) {
                                    return;
                                  }
                                  Navigator.pop(
                                    context,
                                    controller.text.trim(),
                                  );
                                },
                                child: Text(
                                  selectedLanguage == "en" ? "Save" : "حفظ",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      if (newName != null && newName.trim().isNotEmpty) {
                        setState(() {
                          players[index] = newName.trim();
                        });
                      }
                    },
                    icon: Icon(Icons.mode, size: 30, color: Colors.black),
                  ),
                  trailing: IconButton(
                    onPressed: () {
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
                              Icon(Icons.delete, color: Colors.black),
                              SizedBox(width: 10),
                              Text(
                                selectedLanguage == "en"
                                    ? "Delete Player"
                                    : "حذف اللاعب",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          content: Text(
                            selectedLanguage == "en"
                                ? "Are you sure you want to remove this player from the list?\n\nThis action cannot be undone."
                                : "هل أنت متأكد أنك تريد إزالة هذا اللاعب من القائمة؟\n\nلا يمكن التراجع عن هذا الإجراء.",
                            textAlign: selectedLanguage == "en"
                                ? TextAlign.left
                                : TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          actionsPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                selectedLanguage == "en" ? "Cancel" : "الغاء",
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                                setState(() {
                                  players.removeAt(index);
                                });
                              },
                              child: Text(
                                selectedLanguage == "en" ? "Delete" : "حذف",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                      color: const Color.fromARGB(255, 230, 40, 27),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () async {
                TextEditingController controller = TextEditingController();
                String? errorText;

                String? newName = await showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setStateDialog) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.white,
                        title: Row(
                          children: [
                            Icon(Icons.person_add, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              selectedLanguage == "en"
                                  ? "Add Player"
                                  : "اضافة لاعب",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        content: TextField(
                          maxLength: 12,
                          controller: controller,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: selectedLanguage == "en"
                                ? "Enter player name"
                                : "أدخل اسم اللاعب",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            errorText: errorText,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (players.contains(value.trim())) {
                              setStateDialog(() {
                                errorText = selectedLanguage == "en"
                                    ? "Player already exists!"
                                    : "!اللاعب موجود بالفعل";
                              });
                            } else {
                              setStateDialog(() {
                                errorText = null;
                              });
                            }
                          },
                        ),
                        actionsPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              textStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              selectedLanguage == "en" ? "Cancel" : "الغاء",
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (controller.text.trim().isEmpty ||
                                  players.contains(controller.text.trim())) {
                                return;
                              }
                              Navigator.pop(context, controller.text.trim());
                            },
                            child: Text(
                              selectedLanguage == "en" ? "Add" : "اضافة",
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );

                if (newName != null && newName.isNotEmpty) {
                  setState(() {
                    players.add(newName);
                  });
                }
              },
              color: const Color.fromARGB(255, 0, 132, 255),
              padding: EdgeInsets.all(10),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_alt_1, size: 30, color: Colors.white),
                  Text(
                    selectedLanguage == "en" ? " add player" : " اضافة لاعب",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 180,
                child: MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
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

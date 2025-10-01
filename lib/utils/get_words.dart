import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Load saved language from SharedPreferences
Future<String> _loadLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("selectedLanguage") ?? "ar"; // default: Arabic
}

/// Load JSON file according to selected language
Future<List> loadJson() async {
  String lang = await _loadLanguage();

  // Pick file based on language
  String filePath = lang == "en"
      ? 'assets/data/categories_en.json'
      : 'assets/data/categories_ar.json';

  String jsonString = await rootBundle.loadString(filePath);
  List<dynamic> data = jsonDecode(jsonString);
  return data;
}

/// Get a list of words including [word] if not already present
Future<List> getWords(String category, String word) async {
  final data = await loadJson();
  var result = data.firstWhere((item) => item['category'] == category);
  List words = result['items'];

  List temp = words.sublist(0, 8);
  if (temp.every((w) => w["name"] != word)) {
    temp[0] = {"name": word};
  }
  return temp;
}

/// Get one random word from a category
Future<String> getWord(String category) async {
  final data = await loadJson();
  var result = data.firstWhere((item) => item['category'] == category);
  List words = result['items'];
  words.shuffle();
  return words[0]["name"];
}

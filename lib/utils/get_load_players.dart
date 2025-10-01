import 'package:shared_preferences/shared_preferences.dart';

// Save list of players
Future<void> savePlayers(List<String> players) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('players', players);
}

// Load list of players
Future<List<String>> loadPlayers() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('players') ?? [];
}

// Get number of players
Future<int> numberPlayers() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('players')?.length ?? 0;
}
List<Map<String, String>> generateRound(List<String> players) {
  List<String> temp = List.from(players);
  temp.shuffle();
  List<Map<String, String>> rounds = [];
  for (int i = 0; i < temp.length; i++) {
    String asker = temp[i];
    String receiver = temp[(i + 1) % temp.length]; // next one, wraps around
    rounds.add({"asker": asker, "receiver": receiver});
  }
  rounds.shuffle();

  return rounds;
}

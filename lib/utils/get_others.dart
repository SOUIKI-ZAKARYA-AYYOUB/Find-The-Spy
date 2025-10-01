List<String> getOthers(List<String> players, String name) {
  List<String> temp = List.from(players);
  temp.removeAt(players.indexOf(name));
  return temp;
}

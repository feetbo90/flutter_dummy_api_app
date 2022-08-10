class Convert {
  static listToString(List<String> list) {
    String myList = "";
    for(int i =0; i < list.length; i++) {
      if(i == 0) {
        myList = list[i];
      } else {
        myList = "$myList#${list[i]}";
      }
    }
    return myList;
  }
}
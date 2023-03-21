class Game {
  String name;
  int x, y, w, h, id;
  boolean clicked;

  Game(String name, int id) {
    this.name = name;
    this.id = id;
  }

  void BigButton(int x, int y) {
    stroke(0);
    fill(255);
    rect(x, y, width/5, 2*height/5);
  }

  boolean isClicked() {
    if (mousePressed && mouseX >= x && mouseX <= x+ w && mouseY >= y && mouseY <= y + h) {
      clicked = true;
    } else {
      clicked = false;
    }
    return clicked;
  }
}

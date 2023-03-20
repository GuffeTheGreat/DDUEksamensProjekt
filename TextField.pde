class TextField {
  int x, y, w, h;
  String text = "";

  TextField(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update() {
    stroke(0);
    fill(255);
    rect(x, y, w, h);
    noStroke();
    fill(0);
    textSize(x/5);
    //println(x/5);
    text(text, width/2, height/2-h/4);
    textSize(76);
  }

  void keyPressed() {
    if (keyCode != ENTER && keyCode != BACKSPACE) {
      text += key;
    } else if (keyCode == BACKSPACE) {
      text = text.substring(0, max(0, text.length()-1));
    }
  }

  String getText() {
    return text;
  }
}

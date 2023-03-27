class Game {
  String name;
  int x, y, w, h, id;
  boolean clicked;
  PImage preview;

  Game(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(name+".png");
  }

  void BigButton(int x, int y) {
    stroke(0);
    fill(255);
    rect(x, y, width/5, 3*height/5-60);
    image(preview,x+(width/5)/10,y+(3*height/5-60)/10,width/5-(width/5)/5,(3*height/5-60-(3*height/5-60)/5)/2);
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

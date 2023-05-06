class Button {
  String label;
  int x, y, w, h, r, g, b, v, t;
  boolean clicked;
  boolean disabled = false;

  Button(String label, int x, int y, int w, int h, int r, int g, int b, int v, int t) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.g = g;
    this.b = b;
    this.v = v;
    this.t = t;
    this.clicked = false;
  }

  void draw() {
    stroke(223, 180, 83);
    strokeWeight(2);
    fill(255);



    fill(r, g, b, v);
    if (isHover() && !mousePressed) {
      fill(166);
    }
    if (disabled) {
      fill(75);
    }
    rect(x, y, w, h);
    fill(t);
    textAlign(CENTER, CENTER);
    textFont(font4);
    textSize(h/3);
    text(label, x + w/2, y+h/2-h/12);
  }

  boolean isClicked() {
    if (!disabled && mousePressed && mouseButton == (LEFT) && mouseX >= x && mouseX <= x+ w && mouseY >= y && mouseY <= y + h) {
      clicked = true;
    } else {
      clicked = false;
    }
    return clicked;
  }


  boolean isRightClicked() {
    if (!disabled && mousePressed && mouseButton == (RIGHT) && mouseX >= x && mouseX <= x+ w && mouseY >= y && mouseY <= y + h) {
      clicked = true;
    } else {
      clicked = false;
    }
    return clicked;
  }

  boolean isHover() {
    if (!disabled && mouseX >= x && mouseX <= x+ w && mouseY >= y && mouseY <= y + h) {
      return true;
    }
    return false;
  }
}

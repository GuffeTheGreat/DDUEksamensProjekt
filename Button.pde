class Button {
  String label;
  int x, y, w, h;
  boolean clicked;
  boolean disabled = false;

  Button(String label, int x, int y, int w, int h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.clicked = false;
  }

  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(255);
    
    if (disabled){
      fill(90);
    }
    
    if (isHover() && !mousePressed){
      fill(155);
    }
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h/3);
    text(label, x + w/2, y+h/2-h/12);
  }

  boolean isClicked() {
    if (!disabled && mousePressed && mouseX >= x && mouseX <= x+ w && mouseY >= y && mouseY <= y + h) {
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

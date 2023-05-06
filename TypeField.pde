class TypeField {
  String text = "";
  String hint_text = "";
  boolean selected = false;
  PVector location;
  int w, h;
  boolean clicked = false;
  boolean hidden = false;
  boolean numbers_only = false;

  TypeField(PVector loc, int wide, int high, String hint, boolean hide) {
    location = loc;
    w = wide;
    h = high;
    hint_text = hint;
    hidden = hide;
  }

  void keyPress() {
    if (selected) {

      if (keyCode == BACKSPACE && text.length() > 0) {
        text = text.substring(0, text.length()-1);
      } else if (!numbers_only)
      {
        if ((key >=32 && key <=126) && text.length() < 20) {
          text = text + key;
        }
      } else {
        if ((key >=48 && key <=57) && text.length() < 20) {
          text = text + key;
        }
      }
    }
  }

  void display() {

    strokeWeight(2);
    if (selected) {
      stroke(122, 122, 255);
    } else {
      stroke(0);
    }
    fill(255);
    rect(location.x, location.y, w, h, 10);
    textFont(font4);
    textSize(h/2);
    textAlign(LEFT, CENTER);
    if (text == "" && !selected) {
      fill(127);
      text(hint_text, location.x+10, location.y+ (h/2.1));
    } else {
      fill(0);

      if (hidden) {
        String new_text = "";

        for (int i = 0; i<text.length(); i++) {
          new_text += "•";
        }

        text(new_text, location.x+10, location.y+ (h/2.2));
      } else {

        text(text, location.x+10, location.y+ (h/2.2));
      }
    }
  }

  boolean isClicked() {
    if (mousePressed && mouseButton == (LEFT) && mouseX >= location.x && mouseX <= location.x+ w && mouseY >= location.y && mouseY <= location.y + h) {
      clicked = true;
    } else {
      clicked = false;
    }


    return clicked;
  }
}

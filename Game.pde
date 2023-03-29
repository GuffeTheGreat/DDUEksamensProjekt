class Game {
  String name;
  int x, y, w, h, id;
  boolean clicked;
  PImage preview;
  float textWidth;
  int x2;
  int y2;
  int w2;
  int h2;

  int frame = 0;
  int slot_to_stop = 0;

  boolean flashing = false;

  ArrayList<slot_wheel> Slots = new ArrayList<slot_wheel>();



  Game(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
    for (int i = 0; i < 3; i++) {
      Slots.add(new slot_wheel(new PVector(i*200, 450)));
    }
  }

  void draw() {
    frame += 1;
    background(0);



    for (int i = 0; i < Slots.size(); i++) {
      slot_wheel slot = Slots.get(i);

      if (flashing == true) {
        slot.display(abs(-frame/3 + i) % 3);
      } else {
        slot.display(0);
      }
      if (frame % 2 == 0 && slot.stopped == false) {
        slot.speen();
      }
    }
  }

  void spin() {
    //if (key == 'x') {
      if (slot_to_stop < Slots.size()) {
        slot_wheel slot = Slots.get(slot_to_stop);
        slot.stop();
        slot_to_stop += 1;

        if (slot_to_stop == Slots.size()) {
          check_for_alignments();
        }
      } else {

        for (int i = 0; i < Slots.size(); i++) {
          slot_wheel slot = Slots.get(i);
          slot.stopped = false;
          slot_to_stop = 0;
          flashing = false;
        }
      //}
    }
  }

  void check_for_alignments() {
    //Check middle
    boolean mid = true;
    int mid_number = Slots.get(0).number;
    println(mid_number);
    for (int i = 0; i < Slots.size()+1; i++) {
      slot_wheel slot = Slots.get(i);
      println("deez nuts");
      if (slot.number != mid_number) {
        mid = false;
        break;
      }
      if (mid == true) {
        flashing = true;
      }
    }
  }

  void BigButton(int x, int y) {
    stroke(0);
    fill(255);
    rect(x, y, width/5, 3*height/5-60);
    image(preview, x+(width/5)/10, y+(3*height/5-60)/10, width/5-(width/5)/5, (3*height/5-60-(3*height/5-60)/5)/2);
    fill(0);
    textSize(height/20);
    float textWidth = textWidth(name);
    text(name, (x+textWidth/2)+(width/5-textWidth)/2, height/2+(2*((3*height/5-60)/6.5)));
    x2 = x+(width/5)/10+5;
    y2 = height-height/3+height/20;
    w2 = width/5-(width/5)/5-10;
    h2 = (3*height/5-60-(3*height/5-60)/5)/2-height/20;
    rect(x2, y2, w2, h2);
  }

  boolean BigIsClicked() {
    if (mousePressed && mouseX >= x2 && mouseX <= x2 + w2 && mouseY >= y2 && mouseY <= y2 + h2) {
      clicked = true;
    } else {
      clicked = false;
    }
    return clicked;
  }
}

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



  boolean canSpin = true;
  boolean isSpinning = false;
  boolean flashing = false;

  ArrayList<slot_wheel> Slots = new ArrayList<slot_wheel>();



  Game(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
    for (int i = 0; i < 5; i++) {
      Slots.add(new slot_wheel(new PVector(i*300 + (width/2) - (300*2.5), 500), this));
      Slots.get(i).delay_time = (200 * i) + 1000;
    }
  }

  void draw() {
    background(0);

    for (int i = 0; i < Slots.size(); i++) {
      slot_wheel slot = Slots.get(i);
      slot.display();

      
      if (slot.stopped == false && slot.start_time + slot.delay_time < millis() && slot.symbols.get(0).location.y % 250 == 0){
        slot.stopped = true;
        for (int n = 0; n < slot.symbols.size();n++){
          float y_pos = slot.symbols.get(n).location.y/250;
          int new_y_pos = round(y_pos);
          slot.symbols.get(n).location.y = 250.0 * new_y_pos;
        }
        slot.stop();
        
      }
      
      if (slot.stopped == false) {
        slot.speen();
      }
    
  }


}

  void spin() {
    if (canSpin){
      canSpin = false;
      for(int i = 0; i < Slots.size(); i++){
        Slots.get(i).stopped = false;
        Slots.get(i).start_time = millis();
    }
    
  }
  }


void check_alignments(){
  if (Slots.get(4).stopped == true){
    for(int i = 0; i < Slots.size(); i++){
        Slots.get(i).printValues();
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

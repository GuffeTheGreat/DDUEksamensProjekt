class slot_wheel {
  PVector location;
  int number = 1;
  boolean stopped = false;
  ArrayList<Symbol> symbols = new ArrayList<Symbol>();


  slot_wheel(PVector loc) {
    location = loc;
    for (int i = 0; i < 8; i++){
    symbols.add(new Symbol(i, new PVector(location.x,location.y - (250 * i))));
    }
  }







  //Speen
  void speen() {
    number = (number + 1) % 10;
    for (int i = 0; i < 8; i++){
    symbols.get(i).location.y += 50;
    }
  }

  void display(int flash_color) {
    color Col = 0;

    switch(flash_color) {
    case 0:
      Col = color(255);
      break;
    case 1:
      Col = color(255, 0, 0);
      break;
    case 2:
      Col = color(255, 255, 0);
      break;
    }

    fill(Col);
    text(number, location.x, location.y);

    fill(Col, 100);


    text(get_non_center_number(-1), location.x, location.y - 200);
    text(get_non_center_number(1), location.x, location.y + 200);
        for (int i = 0; i < 8; i++){
    symbols.get(i).display();
    }
  }

  int get_non_center_number(int dir) {
    if (dir == 0) {
      return 0;
    }

    if (dir > 0 && number == 9) {
      return 0;
    }

    if (dir < 0 && number == 0) {
      return 9;
    }

    return number + dir;
  }

  void stop() {
    stopped = true;
  }
}
class Symbol{

  PImage symbol_images = loadImage("Symboler.png");
  PVector location;
  int symbol_idx;
  
  Symbol(int idx, PVector loc){
  symbol_idx = idx;
  location = loc;
  }
  
  void display(){
  PImage new_img = symbol_images.get(0,(symbol_images.height/8) * symbol_idx,symbol_images.width,symbol_images.height/8);
  image(new_img,location.x,location.y);
  }
  
}

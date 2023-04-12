class slot_wheel {
  PVector location;
  int number = 1;
  boolean stopped = true;
  boolean toStop = false;
  ArrayList<Symbol> symbols = new ArrayList<Symbol>();

  int start_time;
  int delay_time;
  
  Game parent;

  slot_wheel(PVector loc, Game p) {
    location = loc;
    parent = p;
    for (int i = 0; i < 8; i++){
    symbols.add(new Symbol(i, new PVector(location.x,location.y - (250 * i) + 500),location.y - (250 * 6)));
    }
  }







  //Speen
  void speen() {
    number = (number + 1) % 10;
    for (int i = 0; i < 8; i++){
    symbols.get(i).location.y += 50;
    }
    if (symbols.get(1).location.y % 75 == 0 && toStop == true){
    stop();
    toStop = false;
    stopped = true;
    
    }
  }

  void stop(){
  
    println("a");
    parent.check_alignments();
    
  }

  void display() {

        for (int i = 0; i < 8; i++){
    symbols.get(i).display();
    }
  }
  void printValues(){
    
    for (int i = 0; i < symbols.size();i++){
    println(symbols.get(i).location.y);
    }
  }



}


class Symbol{

  PImage symbol_images = loadImage("Symboler.png");
  PVector location;
  float spawn_y_pos;
  int symbol_idx;
  
  Symbol(int idx, PVector loc,float spawn_y){
  symbol_idx = idx;
  location = loc;
  spawn_y_pos = spawn_y;
  }
  
  void display(){
      PImage new_img = symbol_images.get(0,(symbol_images.height/8) * symbol_idx,symbol_images.width,symbol_images.height/8);
      image(new_img,location.x,location.y);
          if (location.y > 1000){
            location.y = spawn_y_pos;
          }
      }
  
  
}

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
    
    int[] random_numbers = new int[8];
    
    for (int i = 0; i < 8; i++){
      random_numbers[i] = i;
    }
    for (int i = 0; i < 8; i++){
    
      int rng = int(random(0,random_numbers.length));
      symbols.add(new Symbol(random_numbers[rng], new PVector(location.x,location.y - (250 * i) + 500),250 - (250 * 6),location.y));
      
      
      int sub1 = random_numbers[random_numbers.length-1];
      int sub2 = random_numbers[rng];
      
      random_numbers[random_numbers.length-1] = sub2;
      random_numbers[rng] = sub1;
      
      random_numbers = shorten(random_numbers);
    }
  }


  //Speen
  void speen() {
    
    for (int i = 0; i < 8; i++){
    symbols.get(i).location.y += int(50);
    }
    
    if (symbols.get(1).location.y % 75 == 0 && toStop == true){
    stop();
    toStop = false;
    stopped = true;
    
    }
  }

  void stop(){
  
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

  void snap_to_place(){
  
  for (int n = 0; n < symbols.size();n++){
          float y_pos = symbols.get(n).location.y/250;
          int new_y_pos = round(y_pos);
          symbols.get(n).location.y = 250.0 * new_y_pos;
        }
  }


  int[] get_symbol_positions(){
    
    snap_to_place();
    
    int [] return_symbols = new int[3];
    
    for(int i = 0; i < symbols.size();i++){
      if ((symbols.get(i).location.y > -10.0 && symbols.get(i).location.y < 10.0)){
      return_symbols[0] = (symbols.get(i).symbol_idx) + 1;
      return_symbols[1] = (symbols.get((i-1+8)%8).symbol_idx) + 1;
      return_symbols[2] = (symbols.get((i-2+8)%8).symbol_idx) + 1;
      break;
      }
      }
    
    
    return return_symbols;
  }


}


class Symbol{

  PImage symbol_images = loadImage("Symboler.png");
  PVector location;
  float spawn_y_pos;
  float offset_y;
  int symbol_idx;
  
  Symbol(int idx, PVector loc,float spawn_y,float off){
  symbol_idx = idx;
  location = loc;
  spawn_y_pos = spawn_y;
  offset_y = off;
  }
  
  void display(){
      
          if (location.y > 775){
            symbol_idx = int(random(0,8));
            location.y = spawn_y_pos;
          }
    if (location.y < 0 || location.y > 500){
      return;
    }
    
    PImage new_img = symbol_images.get(0,(symbol_images.height/8) * symbol_idx,symbol_images.width,symbol_images.height/8);
      image(new_img,location.x,location.y + offset_y);

      }
  
  
}

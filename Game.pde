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

  int[][] game_result = new int[3][5];
  PVector[] line_positions = new PVector[3];
  boolean show_result = false;
  

  ArrayList<slot_wheel> Slots = new ArrayList<slot_wheel>();



  Game(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
    for (int i = 0; i < 5; i++) {
      Slots.add(new slot_wheel(new PVector(i*300 + (width/2) - (300*2.5), 500), this));
      Slots.get(i).delay_time = (200 * i) + 1000;
    }
    for (int n = 0; n < 3; n++){
      line_positions[n] = new PVector(0,0);
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
  stroke(255,0,255);
  strokeWeight(10);
  
  if (!show_result){
    return;
  }
  
  //Le Lines
  for (int a = 0; a < 3; a++){
    if (line_positions[a].y != 0){
    line(340 + (300 * line_positions[a].x),350 + (250 * a),340 + (300 * line_positions[a].x)+ (300 * line_positions[a].y), 350 + (250 * a));
    }
  }
  
  //The A shape with no brim
  //line(340,850,width/2 - 25,350);
  //line(width/2 -25,350,width - 360,850);
  
  //The V shape with no brim
  //line(340,350,width/2 - 25,850);
  //line(width/2 -25,850,width - 360,350);
  
  


}

  void spin() {
    if (canSpin && credits >= 20){
      canSpin = false;
      credits -= 20;
      show_result = false;
      game_result = new int[3][5];
      for(int i = 0; i < Slots.size(); i++){
        Slots.get(i).stopped = false;
        Slots.get(i).start_time = millis();
    }
    
  }
  }



void check_alignments(){
  if (Slots.get(4).stopped == true){
    
    
    
    // Gets the slot positions in a 2D Array
    int[][] slots_array = new int[Slots.size()][];
    for(int i = 0; i < Slots.size(); i++){
      slot_wheel slot = Slots.get(i);  
      slots_array[i] = slot.get_symbol_positions();
    }
    
    for (int b = 0; b < 3; b++){
    String printer = "";
    
    for (int h = 0; h < 5; h++){
      if (slots_array[h][b] == 0){
      printer += "0 ";
      } else {
      printer += slots_array[h][b] + " ";
      }
    }
    println(printer);
    
    }
    println("");
    // Checks
    
    
    
    // Rows
    
    int [][] best_rows = new int[3][5];
    int [][] temp_rows = new int[3][5];
    

    
    
    for (int i = 0; i < Slots.size(); i++){
    
      for (int n = 0; n < 3; n++){
        
        if (i == 0){
          //Adds Value to first columns
          temp_rows[n][i]= slots_array[i][n];
          
        } else {
          
          //Is value different from last?
          if (temp_rows[n][i-1] != slots_array[i][n]){
            temp_rows[n] = new int[5];
          } 
          
          //Adds value
          temp_rows[n][i] = slots_array[i][n];
          if (get_array_content_size(temp_rows[n]) > get_array_content_size(best_rows[n])){
          best_rows[n] = temp_rows[n].clone();
          }
          
          }
          
        }
        
      }
          for (int n = 0; n < 3; n++){
    String printer = "";
    
    for (int h = 0; h < 5; h++){
      printer += best_rows[n][h] + " ";
      }
    
    println(printer);
    }
    
    game_result = best_rows;
    
    
    //calculate line positions
    
    for (int z = 0; z < 3; z++){
      
      line_positions[z] = new PVector(0,0);
      if (get_array_content_size(game_result[z]) > 2){
        int start_index = 0;
        while(game_result[z][start_index] == 0){
          start_index++;
        }
        line_positions[z] = new PVector(start_index,max(get_array_content_size(game_result[z]) - 1,0));
      }
    }
    
    show_result = true;
    

    canSpin = true;
  }
}

int get_array_content_size(int[] array){
    int value = 0;
    for (int i = 0; i < array.length;i++){
      if (array[i] != 0){
        value++;
      }
    }
  
    return value;
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

class HighOrLow {
  String name;
  int x, y, w, h, id;
  boolean clicked;
  PImage preview;
  float textWidth;
  int x2;
  int y2;
  int w2;
  int h2;

  int card_number = int(random(2, 14));
  int card_next_number = int(random(2, 14));
  
  int payout = 0;

  ArrayList<Button> buttons = new ArrayList<Button>();


  HighOrLow(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");

    for (int i = 0; i < 3; i++) {

      String button_name = "";

      switch(i) {
      case 0:
        button_name = "Lavere";
        break;

      case 1:
        button_name = "Samme";
        break;


      case 2:
        button_name = "Højere";
        break;
      }

      buttons.add(new Button(button_name, width/2 - (300*(2-i)) + 180, int(height*0.6), 250, 150,0,0,0,400,255));
    }
  }

  void guess(int guessMode) {
    

    switch (guessMode) {
    case 0:
      if (card_next_number < card_number) {
        println("win");
        payout += 100;
      } else {
        println("wrong");
        payout = 0;
      }
      break;


    case 1:
      if (card_next_number == card_number) {
        println("win");
        payout += 1000;
      } else {
        println("wrong");
        payout = 0;
      }
      break;


    case 2:
      if (card_next_number > card_number) {
        println("win");
        payout += 100;
      } else {
        println("wrong");
        payout = 0;
      }
      break;
    }
    generate_next();
  }


  void generate_next() {
    card_number = card_next_number;
    card_next_number = int(random(2, 14));
  }

  void display() {
    pushMatrix();
    fill(255);
    textSize(200);
    textAlign(CENTER, TOP);
    text(card_number, width/2, height*0.05);
    
    
    textSize(150);
    text(payout, width/2, height*0.25);
    
    popMatrix();

    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).draw();
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

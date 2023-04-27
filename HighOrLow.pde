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


  int bet_amount = 0;
  int payout = 0;

  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Button> bet_buttons = new ArrayList<Button>();
  Button fold_button = new Button("Stop", width/2 -150, int(height*0.8), 300, 150, 255, 255, 255, 255, 0);

  Card card1 = new Card(new PVector(width/2, 10), card_number);
  Card card2 = new Card(new PVector(width/2, -1000), card_number);

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

      buttons.add(new Button(button_name, width/2 - (300*(2-i)) + 180, int(height*0.5), 250, 150, 255, 255, 255, 255, 0));
      buttons.get(i).disabled = true;
    }

    for (int n = 0; n < 2; n++) {
      String button_name = "";

      switch(n) {
      case 0:
        button_name = "-";
        break;

      case 1:
        button_name = "+";
        break;
      }
      bet_buttons.add(new Button(button_name, width/2 - (300*(1-n)) + 100, int(height*0.675), 100, 100, 255, 255, 255, 255, 0));
    }
  }

  void guess(int guessMode) {

    CardFlip.play();
    credits -= bet_amount;
    credit_notification(-bet_amount);
    displaycredits = credits;

    switch (guessMode) {
    case 0:
      if (card_next_number < card_number) {
        println("win");
        payout += bet_amount*2;
      } else {
        println("wrong");
        payout = 0;
      }
      break;


    case 1:
      if (card_next_number == card_number) {
        println("win");
        payout += bet_amount*2;
      } else {
        println("wrong");
        payout = 0;
      }
      break;


    case 2:
      if (card_next_number > card_number) {
        println("win");
        payout += bet_amount*2;
      } else {
        println("wrong");
        payout = 0;
      }
      break;
    }



    for (int i = 0; i < bet_buttons.size(); i++) {
      bet_buttons.get(i).disabled = payout != 0;
    }

    generate_next();
  }


  void generate_next() {
    card2 = card1.dupe();
    card1.location.y = -500;
    card_number = card_next_number;
    card1.idx = card_number;
    card1.generate_icon();
    card1.generate_number();
    card_next_number = int(random(2, 14));
  }

  void change_bet(boolean increase) {
    if (increase) {
      bet_amount = min(bet_amount + 10, 100);
    } else {
      bet_amount = max(bet_amount - 10, 0);
    }

    if (bet_amount == 0) {
      for (int i = 0; i < buttons.size(); i++) {
        buttons.get(i).disabled = true;
      }
    } else {
      for (int i = 0; i < buttons.size(); i++) {
        buttons.get(i).disabled = false;
      }
    }
  }

  void fold() {
    credit_notification(payout);
    credits += payout;
    payout = 0;

    for (int i = 0; i < bet_buttons.size(); i++) {
      bet_buttons.get(i).disabled = payout != 0;
    }
  }

  void display() {
    pushMatrix();
    fill(255);
    textSize(200);
    textAlign(CENTER, TOP);
    text(card_number, width/2, height*0.05);


    textSize(100);
    text(payout, width/2, height*0.38);


    textSize(100);
    text(bet_amount, width/2, height*0.65);

    popMatrix();


    card1.location.y = lerp(card1.location.y, 10, 0.1);
    card2.display();
    card1.display();

    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).draw();
    }
    for (int n = 0; n < bet_buttons.size(); n++) {
      bet_buttons.get(n).draw();
    }

    fold_button.draw();
  }

  void BigButton(int x, int y) {
    stroke(223, 180, 83);
    strokeWeight(2);
    fill(255, 255, 255, 200);
    rect(x, y, width/5, 3*height/5-60);
    image(preview, x+(width/5)/10, y+(3*height/5-60)/10, width/5-(width/5)/5, (3*height/5-60-(3*height/5-60)/5)/2);
    fill(0);
    float textWidth = textWidth(name);
    textFont(font2);
    textSize(height/25);
    text(name, (x+textWidth/2)+(width/5-textWidth)/2, height/2+(2*((3*height/5-60)/6.5))+7);
    x2 = x+(width/5)/10+5;
    y2 = height-height/3+height/20;
    w2 = width/5-(width/5)/5-10;
    h2 = (3*height/5-60-(3*height/5-60)/5)/2-height/20;
    fill(0, 0, 0, 200);
    rect(x2, y2, w2, h2);
    image(Tree[14], x2+w2/2-h2/2+h2*1/6, y2+h2*1/6, h2*2/3, h2*2/3);
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



class Card {

  PVector location;
  int idx;
  String icon;
  String number;
  color col;

  Card(PVector loc, int index) {
    location = loc;
    idx = index;
    generate_icon();
    generate_number();
  }

  void display() {
    fill(255);
    rect(location.x - 140, location.y, 140 * 2, 200 * 2, 20);
    fill(col);
    pushMatrix();
    //textLeading(-20);
    textSize(50);
    textLeading(40);
    textAlign(LEFT, TOP);
    text(number +"\n" + icon, location.x-140 + 10, location.y + 10);

    pushMatrix();
    translate(location.x-140 + 280 - 10, location.y + 400-10);
    rotate(radians(180));
    //translate(280 - 10,400-10);
    text(number +"\n" + icon, 0, 0);
    popMatrix();
    popMatrix();
  }

  void generate_icon() {
    switch (int(random(0, 3))) {

    case 0:
      icon = "♥";
      col = color(255, 0, 0);
      break;

    case 1:
      icon = "♦";
      col = color(255, 0, 0);
      break;

    case 2:
      icon = "♣";
      col = color(0);
      break;

    case 3:
      icon = "♠";
      col = color(0);
      break;
    }
  }

  void generate_number() {
    switch (idx) {

    case 11:
      number = "J";
      break;
    case 12:
      number = "Q";
      break;
    case 13:
      number = "K";
      break;
    case 14:
      number = "A";
      break;

    default:
      number = str(idx);
      break;
    }
  }

  Card dupe() {

    Card new_card = new Card(new PVector(location.x, location.y), idx);
    new_card.icon = icon;
    new_card.col = col;
    return new_card;
  }
}

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
  Button fold_button = new Button("Stop", width/2 -150, int(height*0.8), 300, 150);


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

      buttons.add(new Button(button_name, width/2 - (300*(2-i)) + 180, int(height*0.5), 250, 150));
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
      bet_buttons.add(new Button(button_name, width/2 - (300*(1-n)) + 100, int(height*0.675), 100, 100));
    }
  }

  void guess(int guessMode) {


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
    card_number = card_next_number;
    card_next_number = int(random(2, 14));
  }

  void change_bet(boolean increase) {
    if (increase) {
      bet_amount = min(bet_amount + 10, 100);
    } else {
      bet_amount = min(bet_amount - 10, 100);
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
    text(payout, width/2, height*0.25);


    textSize(100);
    text(bet_amount, width/2, height*0.65);

    popMatrix();

    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).draw();
    }
    for (int n = 0; n < bet_buttons.size(); n++) {
      bet_buttons.get(n).draw();
    }

    fold_button.draw();
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

class roulette {
  String name;
  int x, y, w, h, id;
  boolean clicked;
  PImage preview;
  float textWidth;
  int x2;
  int y2;
  int w2;
  int h2;

  float rotation = 0.0;
  float angle = 0.0;
  boolean spinning = false;

  ArrayList<Button> Bet_Buttons = new ArrayList<Button>();
  Button Spin_Button;

  bet_chip[] Chips = new bet_chip[39];
  bet_chip[] tutorial_chips = new bet_chip[4];


  roulette(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
    Spin_Button = new Button("Spin", width/2-50, int(height*0.665), 100, 50, 255, 255, 255, 255, 0);
    Spin_Button.disabled = true;
    Bet_Buttons.add(new Button(str(0), width/2 - 700 + 100*(0), height-310 + 100* ceil((12)/12), 100, 100, 0, 120, 72, 255, 255));
    for (int i = 0; i<36; i++) {


      if (i%2 == 0) {
        //col = color(232, 10, 50);
        Bet_Buttons.add(new Button(str(i+1), width/2 - 600 + 100*(i%12), height-310 + 100* ceil((i)/12), 100, 100, 232, 10, 50, 255, 255));
      } else {
        //col = color(10, 10, 10);
        Bet_Buttons.add(new Button(str(i+1), width/2 - 600 + 100*(i%12), height-310 + 100* ceil((i)/12), 100, 100, 10, 10, 10, 255, 255));
      }
    }
    Bet_Buttons.add(new Button("Rød", width/2 - 700 + 100*(0), height-310 + 100* ceil((1)/12), 100, 100, 232, 10, 50, 255, 255));
    Bet_Buttons.add(new Button("Sort", width/2 - 700 + 100*(0), height-310 + 100* ceil((24)/12), 100, 100, 10, 10, 10, 255, 255));

    for (int i = 0; i < tutorial_chips.length; i++) {
      tutorial_chips[i] = new bet_chip(new PVector(20, height/6+ 100*i));
      tutorial_chips[i].chip_lvl = i-1;
      tutorial_chips[i].change_bet(true);
      tutorial_chips[i].tutorial = true;
    }

    Chips[0] = new bet_chip( new PVector(width/2 - 700, height-310 + 100 * 1));
    for (int n = 1; n<37; n++) {

      Chips[n] = new bet_chip( new PVector(width/2 - 600 + 100*((n-1)%12), height-310 + 100* ceil((n-1)/12)));
    }

    Chips[37] = new bet_chip( new PVector(width/2 - 700, height-310 + 100 * 0));
    Chips[38] = new bet_chip( new PVector(width/2 - 700, height-310 + 100 * 2));
  }

  void start_spinning() {

    int take_amount = 0;
    for (int i = 0; i<Chips.length; i++) {
      take_amount -= max(Chips[i].chip_lvl+1, 0) * 25;
    }

    if (credits + take_amount >= 0) {

      spinning = true;
      //rotation = 10;
      rotation = random(30, 300);
      credits += take_amount;
      charity += abs(take_amount);
      credit_notification(take_amount);
      update_credit_database();
    }
  }

  void display() {

    stroke(0);
    fill(70, 20, 15);
    circle(width/2, height/2-200, 700);

    pushMatrix();
    fill(255, 180, 85);
    circle(width/2, height/2-200, 680);
    popMatrix();

    if (spinning) {
      rotation = lerp(rotation, 0.0, 0.01);
    } else {
      rotation = 0.3;
    }
    angle += rotation;

    angle = angle % 360;
    float lastAngle = 0.0;

    stroke(255);
    strokeWeight(2.0);
    for (int i = 0; i <= 36; i++) {

      if (i % 2 != 0) {
        fill(232, 10, 50);
      } else {
        fill(10, 10, 10);
      }

      if (i == 0) {
        fill(0, 150, 70);
      }

      arc(width/2, height/2 - 200, 600, 600, radians(-angle)+ lastAngle, radians(-angle) + lastAngle + radians(1.0/37.0 * 360.0));


      lastAngle += radians(1.0/37.0 * 360.0);
    }


    float lastAngletext = 0.0;
    for (int i = 0; i < 37; i++) {

      draw_text(lastAngletext, i);

      lastAngletext += radians(1.0/37.0 * 360.0);
    }

    fill(255, 255, 255, 0);
    circle(width/2, height/2-200, 500);

    pushMatrix();

    stroke(0);
    strokeWeight(2.0);

    fill(70, 20, 15);
    circle(width/2, height/2-200, 400);
    fill(255, 180, 85);
    circle(width/2, height/2-200, 100);
    fill(255);
    noStroke();
    circle(width/2-20, height/2-220, 20);

    popMatrix();

    for (int i = 0; i < Bet_Buttons.size(); i++) {
      Bet_Buttons.get(i).draw();
    }
    //text(rotation, 80, 120);
    //text(angle, 80, 160);


    if (spinning && rotation < 0.1) {

      int payout_index = (floor((angle+360 - 90)%360/9.7298));


      int payout = (max(Chips[payout_index].chip_lvl+1, 0) * 25) * 10;
      println((floor((angle+360 - 90)%360/9.7298)));

      if (payout_index % 2 != 0 && payout_index != 0) {
        payout += max(Chips[37].chip_lvl+1, 0) * 25 * 2;
      } else if (payout_index % 2 == 0 && payout_index != 0) {

        payout += max(Chips[38].chip_lvl+1, 0) * 25 * 2;
      }
      credits += payout;
      update_credit_database();

      if (payout != 0) {
        credit_notification(payout);
      }
      for (int i = 0; i<Chips.length; i++) {
        Chips[i].chip_lvl = -1;
      }
      spinning = false;
    }

    Spin_Button.draw();

    for (int i = 0; i<Chips.length; i++) {
      Chips[i].display();
    }


    fill(255);
    triangle(width/2 - 10, 10, width/2 + 10, 10, width/2, 40);

    for (int i = 0; i < tutorial_chips.length; i++) {
      tutorial_chips[i].display();
      fill(255);
      textSize(50);
      textAlign(CENTER, CENTER);
      text(" = " + 25*(i+1), 200, height/4 - 50 + 100*i);
    }
  }

  void draw_text(float lastAngle, int number) {
    pushMatrix();
    fill(255);
    translate(width/2.0, height/2.0 -200);
    rotate(radians(-angle) + lastAngle + PI/2 + 0.076);
    textAlign(CENTER, BOTTOM);


    textFont(font4);
    textSize(30);
    text(number, 0, -260);
    popMatrix();
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

class bet_chip {
  PVector location;
  int chip_lvl = -1;

  color col1 = color(0);
  color col2 = color(0);

  boolean tutorial = false;

  bet_chip(PVector loc) {
    location = loc;
  }

  void change_bet(boolean increase) {

    if (increase) {
      chip_lvl = chip_lvl + 1;
    } else {
      chip_lvl = max(-1, chip_lvl - 1);
    }

    switch (chip_lvl%4) {
    case 0:
      col1 = color(255);
      col2 = color (0);
      break;
    case 1:
      col1 = color(255, 0, 0);
      col2 = color(255);
      break;
    case 2:
      col1 = color(0, 0, 255);
      col2 = color(255);
      break;
    case 3:
      col1 = color(10);
      col2 = color(255);
      break;
    }
  }

  void display() {
    if (chip_lvl == -1) {
      return;
    }

    float lastAngle = 0.0;
    for (int i = 0; i<12; i++) {

      if (i%2 == 0) {
        fill(col1);
      } else {
        fill(col2);
      }
      arc(location.x + 50, location.y+ 50, 90, 90, lastAngle, lastAngle + radians(30));
      lastAngle += radians(30);
    }
    pushMatrix();

    fill(col1);
    noStroke();
    circle(location.x + 50, location.y+50, 70);

    stroke(0);
    circle(location.x + 50, location.y+50, 60);

    if (tutorial == false) {
      fill(col2);
      textFont(font4);
      textSize(25);
      textAlign(CENTER);
      text("x" + (floor(chip_lvl/4)+ 1), location.x + 50, location.y + 55);
    }
    popMatrix();
  }
}

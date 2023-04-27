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

  bet_chip[] Chips = new bet_chip[36];


  roulette(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
    Spin_Button = new Button("Spin", width/2-50, int(height*0.665), 100, 50, 255, 255, 255, 255, 0);
    Spin_Button.disabled = true;
    for (int i = 0; i<36; i++) {


      if (i%2 == 0) {
        //col = color(232, 10, 50);
        Bet_Buttons.add(new Button(str(i+1), width/2 - 600 + 100*(i%12), height-310 + 100* ceil((i)/12), 100, 100, 232, 10, 50, 255, 255));
      } else {
        //col = color(10, 10, 10);
        Bet_Buttons.add(new Button(str(i+1), width/2 - 600 + 100*(i%12), height-310 + 100* ceil((i)/12), 100, 100, 10, 10, 10, 255, 255));
      }
    }

    for (int n = 0; n<36; n++) {

      Chips[n] = new bet_chip( new PVector(width/2 - 600 + 100*(n%12), height-310 + 100* ceil((n)/12)));
    }
  }

  void start_spinning() {
    spinning = true;
    rotation = random(90, 200);
    spin_sound.play();
    int take_amount = 0;
    for (int i = 0; i<Chips.length; i++) {
      take_amount -= Chips[i].chip_lvl * 25;
    }
    credits += take_amount;
    credit_notification(take_amount);
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

      if (i % 2 == 0) {
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

    for (int i = 0; i < 36; i++) {
      Bet_Buttons.get(i).draw();
    }
    text(rotation, 80, 80);


    if (spinning && rotation < 0.1) {
      println((int((angle+360 - 90)%360/9.7298)));
      println(Chips[(int((angle+360 - 90)%360/9.7298)) - 1].chip_lvl);

      int payout = (Chips[(int((angle+360 - 90)%360/9.7298)) - 1].chip_lvl * 25) * 10;

      credits += payout;

      if (payout != 0) {
        credit_notification(payout);
      }
      for (int i = 0; i<Chips.length; i++) {
        Chips[i].chip_lvl = 0;
      }
      spinning = false;
    }

    Spin_Button.draw();

    for (int i = 0; i<Chips.length; i++) {
      Chips[i].display();
    }
  }

  void draw_text(float lastAngle, int number) {
    pushMatrix();
    fill(255);
    translate(width/2.0, height/2.0 -200);
    rotate(radians(-angle) + lastAngle + PI/2 + 0.076);
    textAlign(CENTER, BOTTOM);


    text(number, 0, -260);
    popMatrix();
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

class bet_chip {
  PVector location;
  int chip_lvl = 0;

  color col1 = color(0);
  color col2 = color(0);

  bet_chip(PVector loc) {
    location = loc;
  }

  void change_bet(boolean increase) {

    if (increase) {
      chip_lvl = min(4, chip_lvl + 1);
    } else {
      chip_lvl = max(0, chip_lvl - 1);
    }

    switch (chip_lvl) {
    case 1:
      col1 = color(255);
      col2 = color (0);
      break;
    case 2:
      col1 = color(255, 0, 0);
      col2 = color(255);
      break;
    case 3:
      col1 = color(0, 0, 255);
      col2 = color(255);
      break;
    case 4:
      col1 = color(10);
      col2 = color(255);
      break;
    }
  }

  void display() {
    if (chip_lvl == 0) {
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
    popMatrix();
  }
}

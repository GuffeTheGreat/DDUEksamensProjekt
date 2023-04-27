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
  
  ArrayList<Button> Bet_Buttons = new ArrayList<Button>();

  roulette(String name, int id) {
    this.name = name;
    this.id = id;
    preview = loadImage(id+".png");
  }


  void display() {


    fill(70, 20, 15);
    circle(width/2, height/2-200, 700);

    pushMatrix();
    fill(255, 180, 85);
    circle(width/2, height/2-200, 680);
    popMatrix();
    rotation += 0.3;
    rotation = rotation % 360;
    float lastAngle = 0.0;
    for (int i = 0; i < 36; i++) {

      if (i % 2 == 0) {
        fill(232, 10, 50);
      } else {
        fill(90, 180, 75);
      }

      arc(width/2, height/2 - 200, 600, 600, radians(rotation)+ lastAngle, radians(rotation) + lastAngle + radians(1.0/36.0 * 360.0));


      lastAngle += radians(1.0/36.0 * 360.0);
    }


    float lastAngletext = 0.0;
    for (int i = 0; i < 36; i++) {

      draw_text(lastAngletext, i);

      lastAngletext += radians(1.0/36.0 * 360.0);
    }
  }

  void draw_text(float lastAngle, int number) {
    pushMatrix();
    fill(255);
    translate(width/2.0, height/2.0 -200);
    rotate(radians(rotation) + lastAngle - 0.093);
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

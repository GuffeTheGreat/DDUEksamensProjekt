int page = 1;
int loadingcounter = 0;
int a = 0;
int totalPageCount = 60;
boolean changed;

PImage cursorImg;

Button Leaderboard;
Button SpilNu;
Button Konto;
Button Flere1;
Button Flere2;

int kl = (22*width-height)/52;
int kh = height/7;

void setup() {

  // Fullscreen
  fullScreen();

  // Title
  surface.setTitle("Online Casino");

  // Create Buttons
  Leaderboard = new Button("Leaderboard", width/24, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));
  SpilNu = new Button("Spil Nu", width/3, height/7+(2*(height/5)), width/3, 2*(height/5));
  Konto = new Button("Konto", 2*width/3+width/48, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));
  Flere1= new Button("Flere", width/6, height-height/24-height/48, width/6, height/24);
  Flere2= new Button("Flere", 4*width/6, height-3*height/48, width/6, height/24);
}

void draw() {

  // Sideændring Checker
  if (page != a) {
    changed = true;
    a = page;
  }

  // Background Opdaterer
  if (changed == true) {
    println(page);
    background(255  );
    changed = false;
  }

  // Load Side Elementer
  switch (page) {
  case 1:
    fill(0);
    rect(width/3, height/2-10, loadingcounter, 20);
    loadingcounter++;
    if (loadingcounter >= width/3) {
      //noLoop();
      page = 2;
    }
    break;
  case 2:
    SpilNu.draw();
    Konto.draw();
    Leaderboard.draw();
    break;
  case 3:
    Flere1.draw();
    Flere2.draw();
    line(width/2, height/3, width/2, height-height/24);
    break;
  }
}

void mousePressed() {
  switch (page) {
  case 2:
    if (SpilNu.isClicked()) {
      page = 3;
    }
    break;
  }
}

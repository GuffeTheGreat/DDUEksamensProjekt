int page = 2;
int a = 0;
int totalPageCount = 60;
boolean changed;
PImage Background[] = new PImage[totalPageCount+1];
String validCode = "1";
String NemID = "2";

PImage cursorImg;

TextField codeField;
TextField eboxField;
TextField borgerField;
TextField sundhedField;
TextField netbankField;
Button Leaderboard;
Button SpilNu;
Button Konto;

int kl = (22*width-height)/52;
int kh = height/7;

void setup() {

  // Fullscreen
  fullScreen();
  // Title
  surface.setTitle("Online Casino");

  //Login Side
  textAlign(CENTER);
  codeField = new TextField(width/5, (height/2-height/12)+(height/8), 3*(width/5), (height/8));


  // Create Buttons

  Leaderboard = new Button("Leaderboard", width/24, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));
  SpilNu = new Button("Spil Nu", width/3, height/7+(2*(height/5)), width/3, 2*(height/5));
  Konto = new Button("Konto", 2*width/3+width/48, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));

}

void draw() {
  /*
    //Mus
   stroke(255, 0, 0);
   noFill();
   ellipse(mouseX, mouseY, 50, 50);
   */

  // Sideændring Checker
  if (page != a) {
    changed = true;
    a = page;
  }

  // Background Opdaterer
  if (changed == true) {
    println(page);
    //image(Background[page], 0, 0, width, height);
    changed = false;
  }

  // Load Side Elementer

  switch (page) {
  case 2:
    SpilNu.draw();
    Konto.draw();
    Leaderboard.draw();
    break;
  }
}

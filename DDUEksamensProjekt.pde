
import processing.sound.*;

// Sounds
SoundFile win_sound;
SoundFile slot_machine_start;
SoundFile slot_machine_wheelstop;




int credits = 20000;
float displaycredits = credits;

//Credit Notification
String credit_notif_number = "0";
color credit_notif_col = color(0);
float credit_notif_alpha = 1.0;
float credit_notif_y_pos = height/34;


int page = 2;
float loadingcounter = 0;
int a = 0;
int totalPageCount = 60;
int treecounter = 11;
int load;
int tredjedel = width/3;
String name = "Green Jackpot Casino";
boolean changed;
int charity = 7483743;

PImage Tree[] = new PImage[treecounter+1];

Button Leaderboard;
Button SpilNu;
Button Konto;
Button Flere1;
Button Flere2;
Button Tilbage;

Game Game1;
Game Game2;
HighOrLow Game3;
Game Game4;


void setup() {

  // Fullscreen
  fullScreen(P2D);

  // FrameRate
  frameRate(60);

  // Load Sounds
  win_sound = new SoundFile(this, "winsound.wav");
  slot_machine_start = new SoundFile(this, "click.wav");
  slot_machine_wheelstop = new SoundFile(this, "slotwheelstop.wav");

  // Title
  surface.setTitle(name);

  // Load Images
  for (int i = 1; i <= treecounter; i++) {
    Tree[i] = loadImage("data/"+i+"tree.png");
  }

  // Create Buttons
  Leaderboard = new Button("Leaderboard", width/24, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));
  SpilNu = new Button("Spil Nu", width/3, height/7+(2*(height/5)), width/3, 2*(height/5));
  Konto = new Button("Konto", 2*width/3+width/48, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24));
  Flere1 = new Button("Flere", width/6, height-height/24-height/48, width/6, height/24);
  Flere2 = new Button("Flere", 4*width/6, height-3*height/48, width/6, height/24);
  Tilbage = new Button("Tilbage", height/96, height/96, width/16, height/16);

  Game1 = new Game("Totem Lightning", 1);
  Game2 = new Game("Fruit Spins", 2);
  Game3 = new HighOrLow("777 Win", 3);
  Game4 = new Game("Slots", 4);
}

void draw() {

  // Sideændring Checker
  if (page != a) {
    changed = true;
    a = page;
  }

  // Background Opdaterer
  if (changed == true) {
    //println(page);
    background(255);
    changed = false;
  }

  // Load Side Elementer
  switch (page) {
  case 1:
    fill(0);
    //textAlign(CENTER);
    //textSize(height/6.5);
    //text(name, width/2, height/2-20);
    rect(width/3, height/2+5, loadingcounter, 20);




    if (loadingcounter >= width/3) {
      page = 2;
    } else if (loadingcounter == 0) {
      load = 1;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      line(width/8, height/2, 7*width/8, height/2);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
      image(Tree[load], width/21, height-height/9-height/35, width/42, height/35);
      image(Tree[load], width/21+width*19/21, height-height/9-height/35, width/42, height/35);
    } else if (loadingcounter == ceil(width/3*1/6 / 2.0) * 2) {
      load = 2;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      line(width/8, height/2, 7*width/8, height/2);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
      image(Tree[load], width/21, height-height/9-height/16, width/42, height/16);
      image(Tree[load], width/21+width*19/21, height-height/9-height/16, width/42, height/16);
    } else if (loadingcounter == ceil(width/3*2/6 / 2.0) * 2) {
      load = 3;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      line(width/8, height/2, 7*width/8, height/2);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
      image(Tree[load], 3*width/84, height-height/9-height/6, width/21, height/6);
      image(Tree[load], 3*width/84+width*19/21, height-height/9-height/6, width/21, height/6);
    } else if (loadingcounter == ceil(width/3*3/6 / 2.0) * 2) {
      load = 4;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      line(width/8, height/2, 7*width/8, height/2);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
      image(Tree[load], width/56, height-height/9-height/3, width/12, height/3);
      image(Tree[load], width/56+width*19/21, height-height/9-height/3, width/12, height/3);
    } else if (loadingcounter == ceil(width/3*4/6 / 2.0) * 2) {
      load = 5;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      //line(width/8, height/2, 7*width/8, height/2);
      rect(width/8, height-3, 7*width/8, height/2+3);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
      image(Tree[load], -width*11/168, height-height/9-height/2, width/4, height/2);
      image(Tree[load], -width*11/168+width*19/21, height-height/9-height/2, width/4, height/2);
    } else if (loadingcounter == ceil(width/3*5/6 / 2.0) * 2) {
      load = 6;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      image(Tree[load], -4*width/21, height-height/9-3*height/4, width/2, 3*height/4);
      image(Tree[load], -4*width/21+width*19/21, height-height/9-3*height/4, width/2, 3*height/4);
      //line(width/8, height/2, 7*width/8, height/2);
      rect(width/8, height/2-3, 7*width/8-width/8, height/2+3-height/2-3);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
    }


    loadingcounter = loadingcounter + 2;
    break;
  case 2:
    background(255);
    SpilNu.draw();
    Konto.draw();
    Leaderboard.draw();
    textSize(256);
    text(charity, width/2, height/5);
    break;
  case 3:
    background(255);
    Flere1.draw();
    Flere2.draw();
    Tilbage.draw();
    Game1.BigButton(width/30, height/3+40);
    Game2.BigButton(2*width/30+width/5, height/3+40);
    Game3.BigButton(4*width/30+2*width/5, height/3+40);
    Game4.BigButton(5*width/30+3*width/5, height/3+40);
    fill(0);
    textAlign(CENTER);
    textSize(height/3-20);
    text("SPIL", width/2, height/2-height/4);
    line(width/2, height/3-50, width/2, height-height/24);
    textSize(height/12);
    text("Mest Populære", width/4, height/3+10);
    text("De helt nye", 3*width/4, height/3+10);
    break;
  case 4:
    background(100);
    Game1.display();
    Tilbage.draw();
    break;
  case 5:
    Game2.display();
    Tilbage.draw();
    break;
  case 6:
    background(0, 120, 72);
    Game3.display();
    Tilbage.draw();
    break;
  case 7:
    Game4.display();
    Tilbage.draw();
    break;
  }


  if (page != 1) {

    stroke(2);
    fill(255);
    rect(width -300, height/96, 300 - height/96, height/16);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(height/96*3);
    text("Moolah: " + int(ceil(displaycredits)), width - 150, height/96 + height/34);

    increment_credits_counter_smooth();
  }


  textAlign(RIGHT, CENTER);
  credit_notif_alpha = lerp(credit_notif_alpha, 0.0, 0.05);
  credit_notif_y_pos = lerp(credit_notif_y_pos, height/96.0 + height/34.0 + 100.0, 0.05);
  fill(credit_notif_col, int(credit_notif_alpha));
  textSize(height/96*3);
  text(credit_notif_number, width - 75, credit_notif_y_pos);
}

void increment_credits_counter_smooth() {
  displaycredits = (lerp(displaycredits, credits, 0.035));
}



void mousePressed() {
  switch (page) {
  case 2:
    if (SpilNu.isClicked()) {
      page = 3;
    }
    break;
  case 3:
    if (Tilbage.isClicked()) {
      page = 2;
    } else if (Game1.BigIsClicked()) {
      page = 4;
    } else if (Game2.BigIsClicked()) {
      page = 5;
    } else if (Game3.BigIsClicked()) {
      page = 6;
    } else if (Game4.BigIsClicked()) {
      page = 7;
    }
    break;
  case 4:
    //Game1.spin();

    for (int i = 0; i < Game1.line_buttons.size(); i++) {
      if (Game1.line_buttons.get(i).isClicked()) {
        Game1.bet_amount = 4-i;
      }
    }

    if (Game1.SpinButton.isClicked()) {
      Game1.spin();
    }

    if (Game1.PayoutTableButton.isClicked() && Game1.canSpin) {
      Game1.chart_showing = true;
    }

    if (Game1.chart_showing && mouseX >= width - width/15 - 60 && mouseX <= width - width/15 && mouseY >= height/15 && mouseY <= height/15 + 60) {
      Game1.chart_showing = false;
    }


    if (Tilbage.isClicked()) {
      page = 3;
    }
    println("bruh");
    break;
  case 5:
    Game2.spin();
    if (Tilbage.isClicked()) {
      page = 3;
    }
    println("bruh");
    break;
  case 6:
    //Game3.spin();

    for (int i = 0; i < Game3.buttons.size(); i++) {
      if (Game3.buttons.get(i).isClicked()) {
        Game3.guess(i);
      }
    }
    for (int i = 0; i < Game3.bet_buttons.size(); i++) {
      if (Game3.bet_buttons.get(i).isClicked()) {
        Game3.change_bet(i == 1);
      }
    }

    if (Game3.fold_button.isClicked()) {
      Game3.fold();
    }
    if (Tilbage.isClicked()) {
      page = 3;
    }
    println("bruh");
    break;
  case 7:
    Game4.spin();
    if (Tilbage.isClicked()) {
      page = 3;
    }
    println("bruh");
    break;
  }
}

void credit_notification(int amount) {

  credit_notif_number = "";
  if (amount > 0) {
    credit_notif_col = color(0, 255, 0);
    credit_notif_number = "+";
  } else {

    credit_notif_col = color(255, 0, 0);
  }

  credit_notif_alpha = 255.0;
  credit_notif_number += amount;
  credit_notif_y_pos = height/96.0 + height/25.0;
}

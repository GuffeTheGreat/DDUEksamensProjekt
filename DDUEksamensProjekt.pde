import processing.sound.*; //<>// //<>// //<>//
import de.bezier.data.sql.*;

int page = 1;

// Sounds
SoundFile win_sound;
SoundFile slot_machine_start;
SoundFile slot_machine_wheelstop;
SoundFile spin_sound;

SoundFile CardFlip;

MySQL db;

int credits = 20000;
float displaycredits = credits;

//Credit Notification
String credit_notif_number = "0";
color credit_notif_col = color(0);
float credit_notif_alpha = 1.0;
float credit_notif_y_pos = height/34;

PFont font1;
PFont font2;
PFont font3;
PFont font4;
PFont font5;

float loadingcounter = 0;
int a = 0;
int totalPageCount = 60;
int treecounter = 47;
int load = 1;
int tredjedel = width/3;
String name = "Green Jackpot Casino";
String DB_URL = "hc.hyperservers.dk:3306";
String user = "u1_UuV4WCkMbn";
String pass = "O8N=7PpTCi1KaE0Z+k@mgVea"; // shhhh
String high_navn;
int highscore;
int b = 1;
boolean changed;
String pname;
boolean search;
boolean nameExists;
String searchTerm;
int charity = 748343;

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
roulette Game4;


void setup() {

  searchTerm = "";
  pname= "Gæst";

  // Fullscreen
  fullScreen();

  // FrameRate
  frameRate(60);

  font1 = createFont("Font1.TTF", 1);
  font2 = createFont("Font2.ttf", 1);
  font3 = createFont("Font3.TTF", 1);
  font4 = createFont("Font4.TTF", 1);
  font5 = createFont("Font5.ttf", 1);

  // Load Sounds
  win_sound = new SoundFile(this, "winsound.wav");
  slot_machine_start = new SoundFile(this, "click.wav");
  slot_machine_wheelstop = new SoundFile(this, "slotwheelstop.wav");
  spin_sound = new SoundFile(this, "spin.wav");

  CardFlip = new SoundFile(this, "cardflip.wav");

  // Title
  surface.setTitle(name);

  // Load Images
  for (int i = 1; i <= treecounter; i++) {
    Tree[i] = loadImage("data/"+i+"tree.png");
  }

  // Create Buttons
  Leaderboard = new Button("Rangliste", width/24, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24), 10, 10, 10, 200, 255);
  SpilNu = new Button("Spil Nu", width/3, height/7+(2*(height/5)), width/3, 2*(height/5), 10, 10, 10, 200, 255);
  Konto = new Button("Konto", 2*width/3+width/48, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24), 10, 10, 10, 200, 255);
  Flere1 = new Button("Flere", width/6, height-height/24-height/48, width/6, height/24, 0, 0, 0, 200, 255);
  Flere2 = new Button("Flere", 4*width/6, height-3*height/48, width/6, height/24, 0, 0, 0, 200, 255);
  Tilbage = new Button("Tilbage", height/96, height/96, width/16, height/16, 0, 0, 0, 200, 255);

  Game1 = new Game("Forest Fortune", 1);
  Game2 = new Game("Monkey Mayhem", 2);
  Game3 = new HighOrLow("Forest Flip", 3);
  Game4 = new roulette("Tree-Top Roulette", 4);

  db = new MySQL( this, DB_URL, "s1_DDUFilip", user, pass );
  if ( !db.connect() )
  {
    println("Guh!");
  } else
  {
    db.query("SELECT user, highscore FROM personer ORDER BY highscore DESC LIMIT 0,1;");
    while (db.next())
    {
      high_navn = db.getString("user");
      highscore = db.getInt("highscore");
    }
  }
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
  }

  // Load Side Elementer
  switch (page) {
  case 1:
    fill(0);
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
      image(Tree[5], -width*11/168, height-height/9-height/2, width/4, height/2);
      image(Tree[7], -width*11/168+width*19/21, height-height/9-height/2, width/4, height/2);
    } else if (loadingcounter == ceil(width/3*5/6 / 2.0) * 2) {
      load = 6;
      image(Tree[10], 0, 0, width, height);
      image(Tree[9], 0, height-height/9-8, width, height/9+8);
      image(Tree[6  ], -4*width/21, height-height/9-3*height/4, width/2, 3*height/4);
      image(Tree[8], -4*width/21+width*19/21, height-height/9-3*height/4, width/2, 3*height/4);
      //line(width/8, height/2, 7*width/8, height/2);
      rect(width/8, height/2-3, 7*width/8-width/8, height/2+3-height/2-3);
      image(Tree[11], width/8, height/2+10-height/4, 6*width/8, height/4);
    }


    loadingcounter = loadingcounter + 2;
    break;
  case 2:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      image(Tree[13], width/4, (height/7+(2*(height/5)))/2-height/8, width/2, height/4);
      image(Tree[11], width/6, height/4-height/5-50, 4*width/6, height/5);
      fill(0);
      textFont(font1);
      textSize(128);
      textAlign(CENTER, CENTER);
      text(charity, width/2+1, (height/7+(2*(height/5)))/2-height/8+106);
      fill(255);
      text(charity, width/2, (height/7+(2*(height/5)))/2-height/8+105);
      SpilNu.draw();
      Konto.draw();
      Leaderboard.draw();
      changed = false;
    }

    break;
  case 3:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      Tilbage.draw();
      Flere1.draw();
      Flere2.draw();
      Game1.BigButton(width/30, height/3+40);
      Game2.BigButton(2*width/30+width/5, height/3+40);
      Game3.BigButton(4*width/30+2*width/5, height/3+40);
      Game4.BigButton(5*width/30+3*width/5, height/3+40);

      textAlign(CENTER);
      textFont(font3);
      fill(0);
      textSize(height/3-20);
      text("SPIL", width/2+1, height/2-height/4+1);
      fill(223, 180, 83);
      textSize(height/3-20);
      text("SPIL", width/2, height/2-height/4);

      textFont(font1);
      fill(0);
      textSize(height/12);
      text("Klassikerne", width/4+1, height/3+1);
      text("De helt nye", 3*width/4+1, height/3+1);
      fill(223, 180, 83);
      textSize(height/12);
      text("Klassikerne", width/4, height/3);
      text("De helt nye", 3*width/4, height/3);


      stroke(0);
      line(width/2, height/3-50, width/2, height-height/24);
      line(width/4, height/3-80, width*3/4, height/3-80);
      changed = false;
      println("WOOO");
    }
    break;
  case 4:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      Tilbage.draw();
      fill(0, 0, 0, 200);
      rect(width/4, height/8, 2*width/4, 6*height/8);
      pushMatrix();
      textAlign(CENTER);
      textFont(font1);
      textSize(80); //title
      fill(0);
      text("Top Donationer", width/2+1, height/4+1);
      fill(255);
      text("Top Donationer", width/2, height/4);
      textSize(35);
      fill(0);
      //text("Tryk på taster for at søge: "+searchTerm, width/2, 180);
      textFont(font4);
      textSize(25);
      fill(255);
      //if ( searchTerm.equals(""))
      //{
      db.query("SELECT user, highscore FROM personer ORDER BY highscore DESC LIMIT 0,15;");
      //} else
      //{
      //db.query("SELECT user, highscore FROM personer where UPPER(user) like UPPER('%"+searchTerm+"%') ORDER BY highscore DESC LIMIT 0,5;");
      //}

      int iy = height/3;
      while (db.next()) {
        text("Nummer " +b+": " + "Navn: " + db.getString("user")+" \t, Donation: " + db.getInt("highscore"), width/2, iy-10);
        iy+=40;
        b++;
      }
      if (!(pname.equals("Gæst")) && nameExists)
      {
        db.query("SELECT highscore FROM personer where UPPER(user) = UPPER('"+pname+"');");
        while (db.next())
        {
          fill(50, 130, 50);
          text("Din highscore: " + db.getInt("highscore"), width/2, iy+30);
          fill(0);
        }
      }

      popMatrix();
      changed = false;
    }
    break;
  case 5:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      Tilbage.draw();
      changed = false;
      pushMatrix();
      textAlign(CENTER);
      textSize(60); //title
      fill(150, 20, 20);
      text("Dit Navn:" + pname, width/2, 140);
      textSize(30);
      text("Tryk enter når du har skrevet det", width/2, 180);
      textSize(25);
      fill(0);
      /*Knap tmp = knapper.get(0);
      tmp.hover();

      if (tmptext.length() > 12)
      {
        tmp.display(50-(tmptext.length()-12)*2);
      } else
      {
        tmp.display();
      }

      tmp.txt = tmptext;
      if (tmptext.equals(""))
      {
        textAlign(CENTER);
        text("Skriv navn", width/2, height/2+125);
      }
      db.query("select exists(select 1 from personer where UPPER(user) = UPPER('"+tmptext+"'));");
      while (db.next())
      {
        if (db.getInt("exists(select 1 from personer where UPPER(user) = UPPER('"+tmptext+"'))") == 1)
        {
          textSize(20);
          textAlign(CENTER);
          text("Navn eksisterer i database. Eksisterende highscore vil blive opdateret.", width/2, 210);
        }
      }*/
      textAlign(LEFT);
      popMatrix();
    }
    break;
  case 6:
    background(100);
    Game1.display();
    Tilbage.draw();
    break;
  case 7:
    background(100);
    Game2.display();
    Tilbage.draw();
    break;
  case 8:
    background(0, 120, 72);
    Game3.display();
    Tilbage.draw();
    break;
  case 9:
    background(0, 120, 72);
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
    textFont(font1);
    textSize(height/110*3);
    text("Balance: $" + int(ceil(displaycredits)), width - 150, height/96 + height/34);

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
    } else if (Leaderboard.isClicked()) {
      page = 4;
    } else if (Konto.isClicked()) {
      page = 5;
    }
    break;
  case 3:
    if (Tilbage.isClicked()) {
      page = 2;
    } else if (Game1.BigIsClicked()) {
      page = 6;
    } else if (Game2.BigIsClicked()) {
      page = 7;
    } else if (Game3.BigIsClicked()) {
      page = 8;
    } else if (Game4.BigIsClicked()) {
      page = 9;
    }
    break;
  case 4:
    if (Tilbage.isClicked()) {
      page = 2;
    }
    break;
  case 5:
    if (Tilbage.isClicked()) {
      page = 2;
    }
    break;
  case 6:
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
  case 7:
    Game2.spin();
    if (Tilbage.isClicked()) {
      page = 3;
    }
    println("bruh");
    break;
  case 8:
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
  case 9:
    //Game4.spin();
    if (Game4.spinning == false) {
      boolean isEmpty = true;
      for (int i = 0; i < Game4.Bet_Buttons.size(); i++) {

        if (Game4.Bet_Buttons.get(i).isClicked()) {
          Game4.Chips[i].change_bet(true);
        }
        if (Game4.Bet_Buttons.get(i).isRightClicked()) {
          Game4.Chips[i].change_bet(false);
        }

        if (Game4.Chips[i].chip_lvl > 0) {
          isEmpty = false;
        }
      }

      if (isEmpty) {
        Game4.Spin_Button.disabled = true;
      } else {
        Game4.Spin_Button.disabled = false;
      }


      if (Game4.Spin_Button.isClicked()) {
        Game4.start_spinning();
      }
      //Game4.start_spinning();
      if (Tilbage.isClicked()) {
        page = 3;
      }
    }
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

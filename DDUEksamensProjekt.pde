
import processing.sound.*;
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
int b;
boolean changed;
int charity = 0;
int global_charity = 0;
String pname;
boolean search;
boolean nameExists;
String searchTerm;

PImage Tree[] = new PImage[treecounter+1];
PImage foreground1;

Button Leaderboard;
Button SpilNu;
Button Konto;
Button Flere1;
Button Flere2;
Button Tilbage;
Button LogUd;

//Login

TypeField brugerNavn;
TypeField brugerKode;
Button Login;
Button Opret_Bruger;

//Opret_bruger

TypeField OpretbrugerNavn;
TypeField OpretbrugerKode;
Button lavNyBruger;
Button harAlleredeBruger;

//Konto

TypeField AddFunds;
TypeField Donate;
TypeField Withdraw;
Button AddFunds_Confirm;
Button Donate_Confirm;
Button Withdraw_Confirm;


ArrayList<Button> popular_game_buttons = new ArrayList<Button>();

Game Game1;
Game Game2;
HighOrLow Game3;
roulette Game4;


void setup() {

  searchTerm = "";
  pname = "";

  // Fullscreen
  fullScreen();

  // FrameRate
  frameRate(60);

  font1 = createFont("Font1.TTF", 1);
  font2 = createFont("Font2.ttf", 1);
  font3 = createFont("Font3.TTF", 1);
  font4 = createFont("arial.tff", 1);
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

  foreground1 = loadImage("data/foreground_1.png");

  // Create Buttons
  Leaderboard = new Button("Rangliste", width/24, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24), 10, 10, 10, 200, 255);
  SpilNu = new Button("Spil Nu", width/3, height/7+(2*(height/5)), width/3, 2*(height/5), 10, 10, 10, 200, 255);
  Konto = new Button("Konto", 2*width/3+width/48, 2*height/3, (width/3)-(width/24)-(width/48), height-(2*height/3)-(width/24), 10, 10, 10, 200, 255);
  Flere1 = new Button("Flere", width/6, height-height/24-height/48, width/6, height/24, 0, 0, 0, 200, 255);
  Flere2 = new Button("Flere", 4*width/6, height-3*height/48, width/6, height/24, 0, 0, 0, 200, 255);
  Tilbage = new Button("Tilbage", height/96, height/96, width/16, height/16, 0, 0, 0, 200, 255);
  LogUd = new Button("Log Ud", height/96, height/96, width/16, height/16, 0, 0, 0, 200, 255);

  brugerNavn = new TypeField(new PVector(width/2 - 250, height/2 + 0), 500, 60, "Brugernavn", false);
  brugerKode = new TypeField(new PVector(width/2 - 250, height/2 + 100), 500, 60, "Adgangskode", true);
  Login = new Button("Log ind", width/2 - 100, height/2 + 200, 200, 60, 255, 255, 255, 255, 0);
  Opret_Bruger = new Button("Opret Bruger", width/2 - 100, height/2 + 270, 200, 60, 255, 255, 255, 255, 0);

  //OPRET BRUGER
  OpretbrugerNavn = new TypeField(new PVector(width/2 - 250, height/2 + 0), 500, 60, "Ny Brugernavn", false);
  OpretbrugerKode = new TypeField(new PVector(width/2 - 250, height/2 + 100), 500, 60, "Ny Adgangskode", false);
  lavNyBruger = new Button("Opret Ny Bruger", width/2 - 100, height/2 + 200, 200, 60, 255, 255, 255, 255, 0);
  harAlleredeBruger = new Button("Har allerede en bruger?", width/2 - 110, height/2 + 270, 220, 60, 255, 255, 255, 255, 0);

  //Konto

  AddFunds = new TypeField(new PVector(width/2 - 250, height/2 + 0), 500, 60, "Tilføj penge", false);
  Withdraw = new TypeField(new PVector(width/2 - 250, height/2 + 100), 500, 60, "Hæv penge", false);
  Donate = new TypeField(new PVector(width/2 - 250, height/2 + 200), 500, 60, "Doner", false);
  AddFunds_Confirm = new Button("Bekræft", width/2 + 275, height/2 + 0, 100, 60, 255, 255, 255, 255, 0);
  Withdraw_Confirm = new Button("Bekræft", width/2 + 275, height/2 + 100, 100, 60, 255, 255, 255, 255, 0);
  Donate_Confirm = new Button("Bekræft", width/2 + 275, height/2 + 200, 100, 60, 255, 255, 255, 255, 0);

  AddFunds.numbers_only = true;
  Withdraw.numbers_only = true;
  Donate.numbers_only = true;

  //Most Popular
  for (int i = 0; i<4; i++) {
    popular_game_buttons.add(new Button("", width/2 - 670 + ((i%3) * 500), 180 + (ceil(i/3)*400), 340, 320, 0, 0, 0, 0, 0));
  }


  //Newest

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
    db.query("SELECT USER_NAME, USER_DONATIONS FROM users ORDER BY USER_DONATIONS DESC LIMIT 0,1;");
    while (db.next())
    {
      high_navn = db.getString("USER_NAME");
      highscore = db.getInt("USER_DONATIONS");
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
    //println(page);
  }

  // Load Side Elementer
  switch (page) {
  case 1:
    fill(0);
    rect(width/3, height/2+5, loadingcounter, 20);

    if (loadingcounter >= width/3) {
      page = 10;
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
      calculate_global_charity();
      image(Tree[12], 0, 0, width, height);
      image(Tree[13], width/4, (height/7+(2*(height/5)))/2-height/8+150, width/2, height/4);
      image(Tree[11], width/6, height/4-height/5-50, 4*width/6, height/5);
      fill(0);
      textFont(font1);
      textSize(128);
      textAlign(CENTER, CENTER);
      text(global_charity, width/2+3, (height/7+(2*(height/5)))/2-height/8+253);
      fill(255);
      text(global_charity, width/2, (height/7+(2*(height/5)))/2-height/8+250);

      textFont(font4);
      textSize(64);
      fill(0);
      text("Vi har doneret så mange træer:", width/2+3, (height/7+(2*(height/5)))/2-height/8+5 + 103);
      fill(255);
      text("Vi har doneret så mange træer:", width/2, (height/7+(2*(height/5)))/2-height/8+5 + 100);
      SpilNu.draw();
      Konto.draw();
      Leaderboard.draw();
      LogUd.draw();
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
      b = 1;
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
      //} else
      //{
      //db.query("SELECT user, highscore FROM personer where UPPER(user) like UPPER('%"+searchTerm+"%') ORDER BY highscore DESC LIMIT 0,5;");
      //}


      db.query("SELECT USER_NAME, USER_DONATIONS FROM users ORDER BY USER_DONATIONS DESC LIMIT 0,15;");

      int iy = height/3;
      b = 1;
      while (db.next()) {
        text("Nummer " +b+": " + "Navn: " + db.getString("USER_NAME")+" \t, Donation: " + db.getInt("USER_DONATIONS"), width/2, iy-10);
        iy+=40;
        b++;
      }

      /*db.query("SELECT USER_DONATIONS FROM users where UPPER(user) = UPPER('"+pname+"');");
       while (db.next())
       {
       fill(50, 130, 50);
       text("Din highscore: " + db.getInt("USER_DONATIONS"), width/2, iy+30);
       fill(0);
       }*/


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
      textFont(font1);
      textAlign(CENTER);
      textSize(60); //title
      fill(255);
      text("Dit Navn:" + pname, width/2, 140);
      textSize(30);
      //text("Tryk enter når du har skrevet det", width/2, 180);
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

    AddFunds.display();
    Withdraw.display();
    Donate.display();
    AddFunds_Confirm.draw();
    Withdraw_Confirm.draw();
    Donate_Confirm.draw();
    break;
  case 6:
    background(foreground1);
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

  case 10:
    //log in
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);

      image(Tree[11], width/6, height/4-height/5-50, 4*width/6, height/5);
      changed = false;
    }
    brugerKode.display();
    brugerNavn.display();
    Login.draw();
    Opret_Bruger.draw();

    break;

  case 11:
    //opret_bruger
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);

      image(Tree[11], width/6, height/4-height/5-50, 4*width/6, height/5);
      changed = false;
    }
    OpretbrugerKode.display();
    OpretbrugerNavn.display();
    lavNyBruger.draw();
    harAlleredeBruger.draw();
    break;

  case 12:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      changed = false;

      textFont(font1);
      textSize(60);
      textAlign(CENTER);
      fill(255);
      text("Mest Populære", width/2, 100);

      for (int i = 0; i < 4; i++) {
        PImage img = new PImage();
        String name = "";
        switch(i) {
        case 0:
          img = Game1.preview;
          name = Game1.name;
          break;
        case 1:
          img = Game2.preview;
          name = Game2.name;
          break;
        case 2:
          img = Game3.preview;
          name = Game3.name;
          break;
        case 3:
          img = Game4.preview;
          name = Game4.name;
          break;
        }
        popular_game_buttons.get(i).draw();
        fill(255);
        rect(width/2 - 670 + ((i%3) * 500), 180 + (ceil(i/3)*400), 340, 320);
        image(img, width/2 - 650 + ((i%3) * 500), 200 + (ceil(i/3)*400), 300, 220);
        fill(0);
        textFont(font2);
        textSize(40);
        textAlign(CENTER);
        text(name, width/2 - 650 + ((i%3) * 500) + 150, (200 + (ceil(i/3)*400)) + 270);
      }
    }


    Tilbage.draw();
    break;

  case 13:
    if (changed == true) {
      image(Tree[12], 0, 0, width, height);
      changed = false;

      textFont(font1);
      textSize(60);
      textAlign(CENTER);
      fill(255);
      text("Nyeste", width/2, 100);

      for (int i = 0; i < 4; i++) {
        PImage img = new PImage();
        String name = "";
        switch(i) {
        case 0:
          img = Game2.preview;
          name = Game2.name;
          break;
        case 1:
          img = Game4.preview;
          name = Game4.name;
          break;
        case 2:
          img = Game3.preview;
          name = Game3.name;
          break;
        case 3:
          img = Game1.preview;
          name = Game1.name;
          break;
        }
        popular_game_buttons.get(i).draw();
        fill(255);
        rect(width/2 - 670 + ((i%3) * 500), 180 + (ceil(i/3)*400), 340, 320);
        image(img, width/2 - 650 + ((i%3) * 500), 200 + (ceil(i/3)*400), 300, 220);
        fill(0);
        textFont(font2);
        textSize(40);
        textAlign(CENTER);
        text(name, width/2 - 650 + ((i%3) * 500) + 150, (200 + (ceil(i/3)*400)) + 270);
      }
    }


    Tilbage.draw();
    break;
  }


  if (!(page == 1 || page == 10 || page == 11)) {

    stroke(2);
    fill(255);
    rect(width -300, height/96, 300 - height/96, height/16);
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(font1);
    textSize(height/110*3);
    text("Balance: $" + int(round(displaycredits)), width - 150, height/96 + height/34);

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
    } else if (LogUd.isClicked()) {
      brugerNavn.text = "";
      brugerKode.text = "";
      page = 10;
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
    } else if (Flere1.isClicked()) {
      page = 12;
    } else if (Flere2.isClicked()) {
      page = 13;
    }
    break;
  case 4:
    if (Tilbage.isClicked()) {
      page = 2;
    }
    break;
  case 5:
    if (AddFunds.isClicked()) {
      AddFunds.selected = true;
      Withdraw.selected = false;
      Donate.selected = false;
    } else if (Withdraw.isClicked()) {
      AddFunds.selected = false;
      Withdraw.selected = true;
      Donate.selected = false;
    } else if (Donate.isClicked()) {
      AddFunds.selected = false;
      Withdraw.selected = false;
      Donate.selected = true;
    } else {
      AddFunds.selected = false;
      Withdraw.selected = false;
      Donate.selected = false;
    }

    if (AddFunds_Confirm.isClicked()) {
      credits += int(AddFunds.text);
      AddFunds.text = "";
      db.query("UPDATE `s1_DDUFilip`.`users` SET `USER_CASH` = '"+credits+"' WHERE (`USER_NAME` = '" + pname + "');");
    }

    if (Withdraw_Confirm.isClicked()) {
      if (credits-int(Withdraw.text) >= 0) {
        credits -= int(Withdraw.text);
        Withdraw.text = "";
        db.query("UPDATE `s1_DDUFilip`.`users` SET `USER_CASH` = '"+credits+"' WHERE (`USER_NAME` = '" + pname + "');");
      }
    }

    if (Donate_Confirm.isClicked()) {
      if (credits-int(Donate.text) >= 0) {
        credits -= int(Donate.text);
        Donate.text = "";
        db.query("UPDATE `s1_DDUFilip`.`users` SET `USER_CASH` = '"+credits+"' WHERE (`USER_NAME` = '" + pname + "');");
      }
    }

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
    for (int i = 0; i < Game1.line_buttons.size(); i++) {
      if (Game2.line_buttons.get(i).isClicked()) {
        Game2.bet_amount = 4-i;
      }
    }

    if (Game2.SpinButton.isClicked()) {
      Game2.spin();
    }

    if (Game2.PayoutTableButton.isClicked() && Game2.canSpin) {
      Game2.chart_showing = true;
    }

    if (Game2.chart_showing && mouseX >= width - width/15 - 60 && mouseX <= width - width/15 && mouseY >= height/15 && mouseY <= height/15 + 60) {
      Game2.chart_showing = false;
    }


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
          println(i);
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

  case 10:

    if (brugerNavn.isClicked()) {
      brugerNavn.selected = true;
      brugerKode.selected = false;
    } else if (brugerKode.isClicked()) {
      brugerNavn.selected = false;
      brugerKode.selected = true;
    } else {
      brugerNavn.selected = false;
      brugerKode.selected = false;
    }

    if (Login.isClicked()) {

      //Check if userName has a match

      db.query("SELECT * FROM s1_DDUFilip.users where USER_NAME = '" + brugerNavn.text + "';");
      if (db.next()) {

        println(db.getString("USER_CODE"));
        println(brugerKode.text);

        if (db.getString("USER_CODE").equals(brugerKode.text)) {
          pname = brugerNavn.text;
          credits = db.getInt("USER_CASH");
          charity = db.getInt("USER_DONATIONS");
          displaycredits =credits;
          page = 2;
        }
      } else {
        println("no");
      }




      //page = 2;
    }
    if (Opret_Bruger.isClicked()) {

      OpretbrugerNavn.text = "";
      OpretbrugerKode.text = "";
      page = 11;
      brugerNavn.text = "";
      brugerKode.text = "";
    }
    break;

  case 11:

    if (OpretbrugerNavn.isClicked()) {
      OpretbrugerNavn.selected = true;
      OpretbrugerKode.selected = false;
    } else if (OpretbrugerKode.isClicked()) {
      OpretbrugerNavn.selected = false;
      OpretbrugerKode.selected = true;
    } else {
      OpretbrugerNavn.selected = false;
      OpretbrugerKode.selected = false;
    }

    if (lavNyBruger.isClicked() && !(OpretbrugerNavn.text == "" || OpretbrugerKode.text == "")) {

      //Check if userName already exists

      db.query("SELECT * FROM s1_DDUFilip.users where USER_NAME = '" + OpretbrugerNavn.text + "';");
      if (!db.next()) {

        println(db.getString("USER_CODE"));
        println(brugerKode.text);
        println("INSERT INTO 's1_DDUFilip'.'users' ('ID','USER_NAME','USER_CODE','USER_CASH','USER_DONATIONS')VALUES('NULL','"+ OpretbrugerNavn.text +"','" + OpretbrugerKode.text + "','0','0');");
        db.query("INSERT INTO `s1_DDUFilip`.`users` (`USER_NAME`, `USER_CODE`, `USER_CASH`, `USER_DONATIONS`) VALUES ('"+OpretbrugerNavn.text+"', '"+OpretbrugerKode.text+"', '0', '0');");
        page = 10;
      } else {
        println("User Name already exists");
      }

      //page = 2;
    }
    if (harAlleredeBruger.isClicked()) {

      OpretbrugerNavn.text = "";
      OpretbrugerKode.text = "";
      page = 10;
      brugerNavn.text = "";
      brugerKode.text = "";
    }
    break;

  case 12:

    for (int i = 0; i<4; i++) {
      if (popular_game_buttons.get(i).isClicked()) {
        switch (i) {
        case 0:

          page = 6;
          break;
        case 1:

          page = 7;
          break;
        case 2:

          page = 8;
          break;
        case 3:

          page = 9;
          break;
        }
      }
    }

    if (Tilbage.isClicked()) {
      page = 3;
    }
    break;


  case 13:

    for (int i = 0; i<4; i++) {
      if (popular_game_buttons.get(i).isClicked()) {
        switch (i) {
        case 0:

          page = 7;
          break;
        case 1:

          page = 9;
          break;
        case 2:

          page = 8;
          break;
        case 3:

          page = 6;
          break;
        }
      }
    }
    if (Tilbage.isClicked()) {
      page = 3;
    }
    break;
  }
}

void keyPressed() {
  switch(page) {

  case 5:
    AddFunds.keyPress();
    Withdraw.keyPress();
    Donate.keyPress();

  case 10:

    brugerNavn.keyPress();
    brugerKode.keyPress();

    break;


  case 11:

    OpretbrugerNavn.keyPress();
    OpretbrugerKode.keyPress();

    break;
  }
}

void update_credit_database() {
  db.query("UPDATE `s1_DDUFilip`.`users` SET `USER_CASH` = '"+credits+"' WHERE (`USER_NAME` = '" + pname + "');");
  db.query("UPDATE `s1_DDUFilip`.`users` SET `USER_DONATIONS` = '"+charity+"' WHERE (`USER_NAME` = '" + pname + "');");
}

void calculate_global_charity() {
  global_charity = 0;
  db.query("SELECT USER_DONATIONS FROM `s1_DDUFilip`.`users`;");
  while (db.next()) {
    global_charity += db.getInt("USER_DONATIONS");
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

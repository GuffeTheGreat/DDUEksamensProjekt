class slot_wheel {
  PVector location;
  int number = 1;
  boolean stopped = false;


  slot_wheel(PVector loc) {
    location = loc;
  }

  //Speen
  void speen() {
    number = (number + 1) % 10;
  }

  void display(int flash_color) {
    color Col = 0;

    switch(flash_color) {
    case 0:
      Col = color(255);
      break;
    case 1:
      Col = color(255, 0, 0);
      break;
    case 2:
      Col = color(255, 255, 0);
      break;
    }

    fill(Col);
    text(number, location.x, location.y);

    fill(Col, 100);


    text(get_non_center_number(-1), location.x, location.y - 200);
    text(get_non_center_number(1), location.x, location.y + 200);
  }

  int get_non_center_number(int dir) {
    if (dir == 0) {
      return 0;
    }

    if (dir > 0 && number == 9) {
      return 0;
    }

    if (dir < 0 && number == 0) {
      return 9;
    }

    return number + dir;
  }

  void stop() {
    stopped = true;
  }
}

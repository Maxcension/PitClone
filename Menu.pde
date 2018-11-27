void menu() {
  image(fondgif, 0, 0);
  image(icon2, 122, 10);
  menu.play();
  textAlign(CENTER);
  textFont(font1);
  textSize(20);
  fill(255);
  text("v2.0", width/2, height-15);
  textAlign(CENTER);
  textFont(font2);
  textSize(70);
  fill(play_menu);
  text(play, width/2, 350);
  fill(quit_menu);
  text(quit, width/2, 430);
  image(trophy, 10, 10);
  image(gamepad, 426, 5);
  image(custom, 10, 436);
  image(site, 426, 430);


  /* Système pour colorier le texte quand on met la souris dessus */
  if (mouseX <= 295 && mouseX >= 205 && mouseY <= 355 && mouseY >= 300) {
    play_menu = color(153, 117, 194);
  } else if (mouseX <= 305 && mouseX >= 195 && mouseY <= 440 && mouseY >= 385) {
    quit_menu = color(153, 117, 194);
  } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 74 && mouseY >= 10) {
    trophy = loadImage("img/trophy2.png");
  } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 60 && mouseY >= 15) {
    gamepad = loadImage("img/gamepad2.png");
  } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 490 && mouseY >= 436) { 
    custom = loadImage("img/custom2.png");
  } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 490 && mouseY >= 426) {
    site = loadImage("img/icon_site2.png");
  } else {
    play_menu = color(255);
    quit_menu = color(255);
    trophy = loadImage("img/trophy.png");
    gamepad = loadImage("img/gamepad.png");
    custom = loadImage("img/custom.png");
    site = loadImage("img/icon_site.png");
  }

  /* Quand on clique sur Play ou sur Quit */

  if (mousePressed) {
    if (mouseX <= 295 && mouseX >= 205 && mouseY <= 355 && mouseY >= 300) {
      ecran = 1;
      pouet_menu.play();
      pouet_menu.rewind();
      menu.pause();
      menu.rewind();
      image(fondgif, x_fond, 0);
      image(fondgif, x_fond2, 0);
    } else if (mouseX <= 305 && mouseX >= 195 && mouseY <= 440 && mouseY >= 385) {
      pouet_menu.play();
      pouet_menu.rewind();
      exit();
    } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 74 && mouseY >= 10) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 4;
    } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 60 && mouseY >= 15) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 3;
    } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 490 && mouseY >= 436) { 
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 5;
    } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 490 && mouseY >= 426) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 6;
    }
  }
}

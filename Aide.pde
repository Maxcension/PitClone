void aide() {

  if (page_aide == 1) {
    image(fond, 0, 0);
    image(up, width/2-80, 65);
    image(z, width/2-20, 65);
    image(w, width/2+40, 65);
    image(down, width/2-50, 150);
    image(s, width/2+10, 150);

    image(jewel, width/2-20, 220);
    image(jewelspe, width/2-20, 310);

    textFont(font1);
    textSize(17);
    textAlign(CENTER);
    textLeading(25);
    fill(255);
    text(dir1, width/2, 130);
    text(dir2, width/2, 215);
    text(cris1, width/2, 275);
    text(cris2, width/2, 370);

    image(fleche_gauche, 430, 430);
  }

  if (page_aide == 2) {
    image(fond, 0, 0);

    image(jewelspe2, width/2-20, 70);
    image(jewelspe3, width/2-20, 150);
    image(jewelspe4, width/2-20, 260);
    image(jewelspe5, width/2-20, 340);

    textFont(font1);
    textSize(17);
    textAlign(CENTER);
    textLeading(25);
    fill(255);
    text(cris3, width/2, 135);
    text(cris4, width/2, 215);
    text(cris5, width/2, 322.5);
    text(cris6, width/2, 405);

    image(fleche_droite, 10, 430);
  }

  textFont(font2);
  textSize(65);
  textAlign(CENTER);
  text(help, width/2, 50);
  textFont(font2);
  textSize(50);
  fill(play_menu);
  text(retour, width/2, 490);

  if (mouseX <= 310 && mouseX >= 190 && mouseY <= 490 && mouseY >= 450) {
    play_menu = color(153, 117, 194);
  } else if ((mouseX <= 496 && mouseX >= 430 && mouseY <= 496 && mouseY >= 430) && (page_aide == 1)) {
    fleche_gauche = loadImage("img/fleche2.png");
  } else if ((mouseX <= 74 && mouseX >= 10 && mouseY <= 496 && mouseY >= 430) && (page_aide == 2)) {
    fleche_droite = loadImage("img/fleche4.png");
  } else {
    play_menu = color(255);
    fleche_gauche = loadImage("img/fleche.png");
    fleche_droite = loadImage("img/fleche3.png");
  }

  if (mousePressed) {
    if (mouseX <= 310 && mouseX >= 190 && mouseY <= 490 && mouseY >= 450) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 0;
      page_aide = 1;
    } else if ((mouseX <= 496 && mouseX >= 430 && mouseY <= 496 && mouseY >= 430) && (page_aide == 1)) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      page_aide = 2;
    } else if ((mouseX <= 74 && mouseX >= 10 && mouseY <= 496 && mouseY >= 430) && (page_aide == 2)) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      page_aide = 1;
    }
  }
}

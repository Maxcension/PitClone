void customisation() {
  image(fond_menu, 0, 0);

  image(perso, 20, 10, 120, 120);
  image(perso2, 190, 10, 120, 120);
  image(perso3, 360, 10, 120, 120);
  image(perso4, 20, 370, 120, 120);
  image(perso5, 190, 370, 120, 120);
  image(perso6, 360, 370, 120, 120);

  textAlign(CENTER, CENTER);
  textFont(font2);
  textSize(80);
  fill(255);
  text("Choose your skin!", width/2, height/2-60);


  textFont(font2);
  textSize(40);
  fill(255);
  text("Actual: "+skin, width/2, height/2+7.5);


  textFont(font2);
  textSize(50);
  fill(play_menu);
  text("Return", width/2, height/2+60);

  if (mouseX <= 310 && mouseX >= 185 && mouseY <= 335 && mouseY >= 290) {
    play_menu = color(153, 117, 194);
  } else {
    play_menu = color(255);
  }

  if (mousePressed) {
    if (mouseX <= 305 && mouseX >= 190 && mouseY <= 335 && mouseY >= 290) {
      ecran = 0;
      //éviter un bug
      delay(200);
    }
    if (mouseX <= 140 && mouseX >= 20 && mouseY <= 130 && mouseY >= 10) {
      sperso = 1;
      skin = "Normal";
    }
    if (mouseX <= 310 && mouseX >= 190 && mouseY <= 130 && mouseY >= 10) {
      sperso = 2;
      skin = "Dark Red";
    }
    if (mouseX <= 480 && mouseX >= 360 && mouseY <= 130 && mouseY >= 10) {
      sperso = 3;
      skin = "Orange";
    }
    if (mouseX <= 140 && mouseX >= 20 && mouseY <= 490 && mouseY >= 370) {
      sperso = 4;
      skin = "Black & White";
    }
    if (mouseX <= 310 && mouseX >= 190 && mouseY <= 490 && mouseY >= 370) {
      sperso = 5;
      skin = "Green";
    }
    if (mouseX <= 480 && mouseX >= 360 && mouseY <= 490 && mouseY >= 370) {
      sperso = 6;
      skin = "Blue";
    }
  }
}

void customisation() {
  image(fond, 0, 0);

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
  text(chskin, width/2, height/2-60);


  textFont(font2);
  textSize(40);
  fill(255);
  text(chskin2+skin, width/2, height/2+7.5);


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
      pouet_menu2.play();
      pouet_menu2.rewind();
      ecran = 0;
      //éviter un bug
      delay(200);
    }
    if (mouseX <= 140 && mouseX >= 20 && mouseY <= 130 && mouseY >= 10) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 1;
      skin = skin1;
    }
    if (mouseX <= 310 && mouseX >= 190 && mouseY <= 130 && mouseY >= 10) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 2;
      skin = skin2;
    }
    if (mouseX <= 480 && mouseX >= 360 && mouseY <= 130 && mouseY >= 10) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 3;
      skin = skin3;
    }
    if (mouseX <= 140 && mouseX >= 20 && mouseY <= 490 && mouseY >= 370) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 4;
      skin = skin4;
    }
    if (mouseX <= 310 && mouseX >= 190 && mouseY <= 490 && mouseY >= 370) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 5;
      skin = skin5;
    }
    if (mouseX <= 480 && mouseX >= 360 && mouseY <= 490 && mouseY >= 370) {
      pouet_menu2.play();
      pouet_menu2.rewind();
      sperso = 6;
      skin = skin6;
    }
  }
}

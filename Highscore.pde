void highscore() {
  image(fond_menu, 0, 0);
  fill(255);

  for (int i= 0; i <= 10; i += 1) {
    TableRow row = table_score.getRow(table_score.lastRowIndex()-i);
    String highscore = row.getString("name") + ": " + row.getString("score");
    espace_highscore += 32.5;
    textAlign(CENTER);
    textFont(font1);
    textSize(27.5);
    text(highscore, width/2, 72.5+espace_highscore);
  }
  espace_highscore = 0;

  textFont(font2);
  textSize(80);
  text("Highscore", width/2, 70);
  textFont(font2);
  textSize(50);
  fill(play_menu);
  text("Return", width/2, 485);

  if (mouseX <= 305 && mouseX >= 190 && mouseY <= 485 && mouseY >= 450) {
    play_menu = color(153, 117, 194);
  } else {
    play_menu = color(255);
  }

  if (mousePressed) {
    if (mouseX <= 305 && mouseX >= 190 && mouseY <= 485 && mouseY >= 450) {
      ecran = 0;
    }
  }
}

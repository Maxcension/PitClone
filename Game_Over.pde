void gameover() {

  pouet3.play();
  pouet3.rewind();
  coeur3 = loadImage("img/heart_bw.png");
  nbre_coeur = 0;
  bg.pause();
  gameover.play();
  gameover.rewind();
  menu.play();

  /* Tableau *\
   
  /* Nom */
  prename = showInputDialog(nickname);

  if (prename == null) {
    noLoop();
    exit();
  }

  while (prename.length() < 3) {
    prename = showInputDialog(nickname2);
  }
  String name = prename.substring(0, 3);
  name = name.toUpperCase();

  /* Nouvelle rangée avec l'id, le score et le nom */
  TableRow row = table_score.addRow();
  row.setInt("id", table_score.lastRowIndex());
  row.setString("name", name);
  row.setInt("score", score);

  /* Triage et enregistrement de la nouvelle table */
  table_score.sort("score");
  saveTable(table_score, "data/highscore/score.csv");

  image(fond, 0, 0);
  textAlign(CENTER);
  fill(255);
  textFont(font2);
  textSize(80);
  text("GAME OVER", width/2, 70);
  textFont(font2);
  textSize(30);
  text(go, width/2, 480);

  /* Boucle pour afficher l'highscore de manière optimisée */
  for (int i= 0; i <= 10; i += 1) {
    row = table_score.getRow(table_score.lastRowIndex()-i);
    String highscore = row.getString("name") + ": " + row.getString("score");
    espace_highscore += 32.5;
    textAlign(CENTER);
    textFont(font1);
    textSize(27.5);
    text(highscore, width/2, 75+espace_highscore);
  }
  espace_highscore = 0;
  noLoop();
}

/* Procédure qui permet de remettre tout correctement avant de rejouer */
void rejouer() {
  nbre_coeur = 3;
  score = 0;
  haut = 0;
  bas = 0;
  y_balle = random(0, 460);
  y_ballespe = random(0, 460);
  y_perso = 215;
  x_fond = 0;
  x_fond2 = 500;
  x_balle = 500;
  x_ballespe = 730;
  vitesse_perso = 6.0;
  vitesse_bf = 2.5;
  bg.rewind();
  coeur = loadImage("img/heart.png");
  coeur2 = loadImage("img/heart.png");
  coeur3 = loadImage("img/heart.png");
}

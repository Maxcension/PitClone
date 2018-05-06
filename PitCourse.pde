/* Import */

import gifAnimation.*;
import ddf.minim.*;

/* Variables */

float haut, bas, vitesse_perso, y_perso, y_balle, y_ballespe, x_balle, x_ballespe, x_fond, x_fond2, vitesse_bf, espace_highscore;
int ca, ca2, score, nbre_coeur, ecran, highscore_design;
String prename;
color play_menu, quit_menu;
PImage coeur, coeur2, coeur3, fond, fond_menu, fond_go, icon, icon2, up, down, z, w, s, gamepad, trophy;
PFont font1, font2;
Table table_score;
Minim minim;
AudioPlayer bg, menu, pouet, pouet2, pouet3, pouet_menu, gameover;
Gif persogif, jewel, jewelspe;

/* Initialisation */

void setup() {
  /* Fenêtre */
  frameRate(60);
  smooth(2);
  size(500, 500); 


  /* Valeurs varibles */
  score = 0;
  y_perso = 215;
  x_balle = 500;
  x_ballespe = 730;
  y_balle = random(0, 460);
  y_ballespe = random(0, 460);
  vitesse_perso = 6.0;
  vitesse_bf = 2.5;
  haut = 0;
  bas = 0;
  nbre_coeur = 3;
  x_fond = 0;
  x_fond2 = 500;
  ca = 0;
  ca2 = 0;
  highscore_design = 1;
  ecran = 0;
  play_menu = color(255);
  quit_menu = color(255);
  espace_highscore = 3;

  /*  Chargements images */
  coeur = loadImage("img/heart.png");
  coeur2 = loadImage("img/heart.png");
  coeur3 = loadImage("img/heart.png");
  fond = loadImage("img/fond.png");
  fond_menu = loadImage("img/fond_menu.png");
  fond_go = loadImage("img/fond_go.png");
  icon = loadImage("img/icon.png");
  icon2 = loadImage("img/icon2.png");
  up = loadImage("img/key_up.png");
  down = loadImage("img/key_down.png");
  z = loadImage("img/key_Z.png");
  w = loadImage("img/key_W.png");
  s = loadImage("img/key_S.png");
  gamepad = loadImage("img/gamepad.png");
  trophy =loadImage("img/trophy.png");
  surface.setIcon(icon);

  /* Musique */
  minim = new Minim(this);
  bg = minim.loadFile("sounds/03h49.mp3");
  menu = minim.loadFile("sounds/menu.mp3");
  pouet = minim.loadFile("sounds/pouet.mp3");
  pouet2 = minim.loadFile("sounds/pouet2.mp3");
  pouet3 = minim.loadFile("sounds/pouet3.mp3");
  pouet_menu = minim.loadFile("sounds/pouet_menu.mp3");
  gameover = minim.loadFile("sounds/gameover.mp3");

  /* Gifs */
  persogif = new Gif(this, "img/bat.gif");
  persogif.play();
  jewel = new Gif(this, "img/jewel.gif");
  jewel.play();
  jewelspe = new Gif(this, "img/jewel2.gif");
  jewelspe.play();

  /* Fonts */
  font1 = createFont("font/pixel.ttf", 40, true);
  font2 = createFont("font/game.ttf", 40, true);

  /* Table highscore */
  table_score = loadTable("data/highscore/score.csv", "header");
}

/* Fonctionnement */

void draw() {
  /* Si ecran est égal à 0, alors c'est le menu, s'il est égal à 1, alors c'est le jeu, s'il est égal à 2, alors c'est le game over, s'il égal à 3 c'est le menu d'aide, 
   s'il égal à 4, c'est le menu d'highscore */
  if (ecran == 0) {
    menu();
  } else if (ecran == 1) {
    jeu();
    defilement();
    score();
  } else if (ecran == 2) {
    gameover();
  } else if (ecran == 3) {
    aide();
  } else if (ecran == 4) {
    highscore();
  }
}

/* Défilement */

void defilement() {

  /*Système défilement balle:
   Si l'abscisse de la balle est supérieur ou égal à 0, alors il est soustrait à la vitesse de la balle */
  if (x_balle >= 0) {
    x_balle -= vitesse_bf;
  }

  /* Système perte de point:
   Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est supérieur à 1, alors on soustrait 1 au nombre de coeur, on remet l'ordonné (y_balle) à un nombre 
   aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500, on baisse la vitesse de la balle en la multipliant par 0.85 et on joue pouet3 */
  if (x_balle <= 0 && nbre_coeur > 1) {
    nbre_coeur--;
    y_balle = random(0, 460);
    x_balle = 500;
    vitesse_bf *= 0.85;
    pouet3.play();
    pouet3.rewind();

    /* Système pour mettre les coeurs en noir et blanc */
    if (nbre_coeur == 2) {
      coeur = loadImage("img/heart_bw.png");
    }
    if (nbre_coeur == 1) {
      coeur2 = loadImage("img/heart_bw.png");
    }
  }

  /* Système pour perdre: 
   Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est égal à 1, alors on met le dernier coeur en bw, on arrête le fonctionnement du jeu, ecran est
   égal à 2 ce qui veut dire qu'on affiche l'ecran de game over*/
  if (x_balle <= 0 && nbre_coeur == 1) {
    ecran = 2;
  }

  /* Système point:  
   Si l'ordonnée de la balle est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle est supérieure ou égal à l'ordonnée du perso-10 (plus facile) 
   ET si l'abscisse de la balle est égal à 50 alors on on remet l'ordonné (y_balle) à un nombre aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500), on
   ajoute 1 point à la variable score, on joue le son pouet et on met la variable chiffrealéatoire à un chiffre entre 1 et 10 sans virgule*/
  if (y_balle <= y_perso +60 && y_balle >= y_perso-20 && x_balle <= 50) {
    y_balle = random(0, 460);
    x_balle = 500;
    score++;
    pouet.play();
    pouet.rewind();
    ca = (int)random(1, 10);

    /* Système pour accélérer la balle 1 fois sur 2
     Si le score est pair, alors on accélère */
    if (score%2 == 0) {
      acceleration();
    }

    /* Si le chiffre aléatoire est 5, alors on met ca2 (deuxième variable pour eviter qu'elle ne change en plein trajet) égal à lui */
    if (ca == 5) {
      ca2 = ca;
    }
  }

  /* Balle spéciale */
  if (ca2 == 5) {
    /*Si l'abscisse de la balle spé est supérieur ou égal à 0, alors il est soustrait à la vitesse de la balle */
    if (x_ballespe >= 0) {
      x_ballespe -= vitesse_bf;
    }

    /* Système balle spé:  
     Si l'ordonnée de la balle spé est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle spé est supérieure ou égal à l'ordonnée du perso-10 
     (plus facile) ET si l'abscisse de la balle spé est égal à 50 alors on joue le son pouet2, on augmente la vitesse du perso (c'est le pouvoir), on remet la balle spé à son état
     initial puis on remet ca2 au nouveau chiffre aléatoire */
    if (y_ballespe <= y_perso +60 && y_ballespe >= y_perso-20 && x_ballespe <= 50) {
      pouet2.play();
      pouet2.rewind();
      vitesse_perso *= 1.1;
      x_ballespe = 730;
      y_ballespe = random(0, 460);
      ca2 = ca;
    }

    /* Si l'abscisse de la balle spé est inférieur ou égal à 0, alors on joue pouet3, on remet la balle spé à son état initial puis on remet ca2 au nouvea chiffre aléatoire */
    if (x_ballespe <= 0) { 
      pouet3.play();
      pouet3.rewind();
      x_ballespe = 730;
      ca2 = ca;
      y_ballespe = random(0, 460);
    }
  }

  /* Système de déplacement avec zone de jeu:
   Si l'ordonné du perso est supérieur ou égal à 0 ET si le l'ordonnée du perso est inférieur ou égal à 430 (taille image) alors on ajoute à l'ordonné du perso le calcul de bas et 
   haut multiplié par la vitesse du perso 
   Cela permet un déplacement fluide*/
  if (y_perso >= 0 && y_perso <= 430) {
    y_perso += (bas - haut) * vitesse_perso;
  }

  /* Système de collision*/
  /* Si l'ordonnée du perso est inférieur ou égal à 0 alors on lui ajoute 1 pour ne pas le bloquer en dehors de la zone de jeu */
  if (y_perso <= 0) {
    y_perso++;
  }

  /* Si l'ordonnée du perso est supérieur ou égal à 430 (taille image) alors on lui enlève 1 pour ne pas le bloquer en dehors de la zone de jeu */
  if (y_perso >= 430) {
    y_perso--;
  }
}

/* Affichage score */
void score() {
  fill(153, 117, 194);
  textSize(50);
  textFont(font1);
  text(score, width/2, 15);
  textAlign(CENTER, CENTER);
}

/* Accélération: */
void acceleration() {
  vitesse_bf *= 1.05;
}

/* Les différents ecrans de jeu */

/* menu */

void menu() {
  image(fond_menu, 0, 0);
  image(icon2, 122, 10);
  menu.play();
  textAlign(CENTER);
  textFont(font1);
  textSize(20);
  fill(255);
  text("v1.3", width/2, height-15);
  textAlign(CENTER);
  textFont(font2);
  textSize(70);
  fill(play_menu);
  text("Play", width/2, 350);
  fill(quit_menu);
  text("Quit", width/2, 430);
  image(trophy, 10, 10);
  image(gamepad, 426, 5);

  /* Système pour colorier le texte quand on met la souris dessus */
  if (mouseX <= 295 && mouseX >= 205 && mouseY <= 355 && mouseY >= 300) {
    play_menu = color(153, 117, 194);
  } else if (mouseX <= 305 && mouseX >= 195 && mouseY <= 440 && mouseY >= 385) {
    quit_menu = color(153, 117, 194);
  } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 74 && mouseY >= 10) {
    trophy = loadImage("img/trophy2.png");
  } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 60 && mouseY >= 15) {
    gamepad = loadImage("img/gamepad2.png");
  } else {
    play_menu = color(255);
    quit_menu = color(255);
    trophy = loadImage("img/trophy.png");
    gamepad = loadImage("img/gamepad.png");
  }

  /* Quand on clique sur Play ou sur Quit */
  if (mousePressed) {
    if (mouseX <= 295 && mouseX >= 205 && mouseY <= 355 && mouseY >= 300) {
      ecran = 1;
      pouet_menu.play();
      pouet_menu.rewind();
      menu.pause();
      menu.rewind();
      image(fond, x_fond, 0);
      image(fond, x_fond2, 0);
    } else if (mouseX <= 305 && mouseX >= 195 && mouseY <= 440 && mouseY >= 385) {
      exit();
    } else if (mouseX <= 74 && mouseX >= 10 && mouseY <= 74 && mouseY >= 10) {
      ecran = 4;
    } else if (mouseX <= 490 && mouseX >= 426 && mouseY <= 60 && mouseY >= 15) {
      ecran = 3;
    }
  }
}

/* Jeu */

void jeu() {
  /* 1ere image qui commence à x_fond (0), qui défile jusqu'à que son abscisse atteigne -500 et qui se remet à ses coords de départ */
  image(fond, x_fond, 0);
  x_fond -= vitesse_bf;
  if (x_fond <= -500) {
    x_fond = 0;
  }

  /* 2nd image qui commence à x_fond2 (500), qui défile jusqu'à que son abscisse (x_fond2) atteigne 0 et qui se remet à ses coords de départ */
  image(fond, x_fond2, 0);
  x_fond2 -= vitesse_bf;
  if (x_fond2 <= 0) {
    x_fond2 = 500;
  }

  /* Sprites */

  /* Si ca2 est égal à 5, alors on affiche le sprite de la balle spé. Celle variable est là pour que la balle spé ne disparaisse pas quand la bouclese rejoue */
  if (ca2 == 5) {
    image(jewelspe, x_ballespe, y_ballespe);
  }

  image(jewel, x_balle, y_balle);
  image(persogif, 25, y_perso);
  image(coeur, 462, 5, 32, 32);
  image(coeur2, 425, 5, 32, 32);
  image(coeur3, 388, 5, 32, 32);
  bg.play();
}

/* Game Over */

void gameover() {
  pouet3.play();
  pouet3.rewind();
  coeur3 = loadImage("img/heart_bw.png");
  nbre_coeur = 0;
  image(fond_go, 0, 0);
  textAlign(CENTER);
  fill(255);
  textFont(font2);
  textSize(80);
  text("GAME OVER", width/2, 70);
  textFont(font2);
  textSize(30);
  text("Press R to replay or M to go to the main menu", width/2, 480);
  bg.pause();
  gameover.play();
  gameover.rewind();
  menu.play();

  /*Fonctionnement table highscore */

  /* Nom */
  prename = new Dialog().readString("Nickname ? (3 letters max)");
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

void aide() {
  image(fond_menu, 0, 0);
  image(up, width/2-80, 65);
  image(z, width/2-20, 65);
  image(w, width/2+40, 65);
  image(down, width/2-50, 150);
  image(s, width/2+10, 150);

  image(jewel, width/2-20, 230);
  image(jewelspe, width/2-20, 330);

  textFont(font2);
  textSize(65);
  textAlign(CENTER);
  text("Help", width/2, 50);
  textFont(font2);
  textSize(50);
  fill(play_menu);
  text("Return", width/2, 490);


  textFont(font1);
  textSize(17);
  textAlign(CENTER);
  textLeading(25);
  fill(255);
  text("Press UP, Z or W to go up", width/2, 130);
  text("Press DOWN or S to go down", width/2, 215);
  text("This is a basic crystal\n You have to catch it or you'll lose a heart", width/2, 290);
  text("This is a special crystal\n You aren't obligated to catch it\n It increase the speed of Pit", width/2, 390);

  if (mouseX <= 290 && mouseX >= 210 && mouseY <= 490 && mouseY >= 440) {
    play_menu = color(153, 117, 194);
  } else {
    play_menu = color(255);
  }

  /* Quand on clique sur Play ou sur Quit */
  if (mousePressed) {
    if (mouseX <= 290 && mouseX >= 210 && mouseY <= 490 && mouseY >= 440) {
      ecran = 0;
    }
  }
}

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

  /* Quand on clique sur Play ou sur Quit */
  if (mousePressed) {
    if (mouseX <= 305 && mouseX >= 190 && mouseY <= 485 && mouseY >= 450) {
      ecran = 0;
    }
  }
}

/* Déplacement */

void keyReleased() {
  if ((key == CODED && keyCode == UP) || key == 'Z' || key == 'W' || key == 'z' || key == 'w') {
    haut = 0;
  } else if ((key == CODED && keyCode == DOWN) || key == 'S' || key == 's') {
    bas = 0;
  }
}

void keyPressed() {
  if ((key == CODED && keyCode == UP) || key == 'Z' || key == 'W' || key == 'z' || key == 'w') {
    haut = 1;
  } else if ((key == CODED && keyCode == DOWN) || key == 'S' || key == 's') {
    bas = 1;
  }

  /* Système pour rejouer
   Si l'ecran de jeu est le Game Over et qu'on appuit sur la touche r, alors la boucle se relance et on remet l'ecran de jeu et on fait appel à la procédure rejouer */
  else if (ecran == 2 && (key == 'r' || key == 'R')) {
    loop();
    ecran = 1;
    rejouer();
    menu.pause();
    menu.rewind();
  }

  /* Si l'ecran de jeu est le Game Over et qu'on appuit sur la touche m, alors la boucle se relance et on remet l'ecran du menu et on fait appel à la procédure rejouer */
  else if (ecran == 2 && (key == 'm' || key == 'M')) {
    loop();
    ecran = 0;
    rejouer();
  }
}

/* Procédure qui permet de remettre tout correctement avant de rejouer */
void rejouer() {
  nbre_coeur = 3;
  score = 0;
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
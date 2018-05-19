/* Import */

import gifAnimation.*;
import ddf.minim.*;
import static javax.swing.JOptionPane.*;

/* Variables */

float haut, bas, vitesse_perso, y_perso, y_balle, y_ballespe, x_balle, x_ballespe, x_fond, x_fond2, vitesse_bf, espace_highscore;
int ca, ca2, ca3, score, nbre_coeur, ecran, highscore_design, sperso, sballe, page_aide;
String prename, skin;
color play_menu, quit_menu;
PImage coeur, coeur2, coeur3, fond, fond_menu, fond_go, icon, icon2, up, down, z, w, s, gamepad, trophy, custom, site, fleche_gauche, fleche_droite;
PFont font1, font2;
Table table_score;
Minim minim;
AudioPlayer bg, menu, pouet, pouet2, pouet3, pouet4, pouet_menu, gameover;
Gif perso, perso2, perso3, perso4, perso5, perso6, jewel, jewelspe, jewelspe2, jewelspe3, jewelspe4, jewelspe5;

/* Initialisation */

void setup() {
  /* Fenêtre */
  frameRate(60);
  smooth(0);
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
  ca3 = 0;
  highscore_design = 1;
  ecran = 0;
  play_menu = color(255);
  quit_menu = color(255);
  espace_highscore = 3;
  sperso = 1;
  sballe = 0;
  skin = "Normal";
  page_aide = 1;

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
  trophy = loadImage("img/trophy.png");
  custom = loadImage("img/custom.png");
  site = loadImage("img/icon_site.png");
  fleche_gauche = loadImage("img/fleche.png");
  fleche_droite = loadImage("img/fleche3.png");
  surface.setIcon(icon);

  /* Musique */
  minim = new Minim(this);
  bg = minim.loadFile("sounds/03h49.mp3");
  menu = minim.loadFile("sounds/menu.mp3");
  pouet = minim.loadFile("sounds/pouet.mp3");
  pouet2 = minim.loadFile("sounds/pouet2.mp3");
  pouet3 = minim.loadFile("sounds/pouet3.mp3");
  pouet4 = minim.loadFile("sounds/pouet4.mp3");
  pouet_menu = minim.loadFile("sounds/pouet_menu.mp3");
  gameover = minim.loadFile("sounds/gameover.mp3");

  /* Gifs */
  perso = new Gif(this, "img/bat1.gif");
  perso.play();
  perso2 = new Gif(this, "img/bat2.gif");
  perso2.play();
  perso3 = new Gif(this, "img/bat3.gif");
  perso3.play();
  perso4 = new Gif(this, "img/bat4.gif");
  perso4.play();
  perso5 = new Gif(this, "img/bat5.gif");
  perso5.play();
  perso6 = new Gif(this, "img/bat6.gif");
  perso6.play();

  jewel = new Gif(this, "img/jewel.gif");
  jewel.play();
  jewelspe = new Gif(this, "img/jewel2.gif");
  jewelspe.play();
  jewelspe2 = new Gif(this, "img/jewel3.gif");
  jewelspe2.play();
  jewelspe3 = new Gif(this, "img/jewel4.gif");
  jewelspe3.play();
  jewelspe4 = new Gif(this, "img/jewel5.gif");
  jewelspe4.play();
  jewelspe5 = new Gif(this, "img/jewel6.gif");
  jewelspe5.play();

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
  } else if (ecran == 2) {
    gameover();
  } else if (ecran == 3) {
    aide();
  } else if (ecran == 4) {
    highscore();
  } else if (ecran == 5) {
    customisation();
  }
}

void keyReleased() {
  if (((key == CODED && keyCode == UP) || key == 'Z' || key == 'W' || key == 'z' || key == 'w') && (ecran == 1)) {
    haut = 0;
  } else if (((key == CODED && keyCode == DOWN) || key == 'S' || key == 's') && (ecran == 1)) {
    bas = 0;
  }
}

void keyPressed() {
  if (((key == CODED && keyCode == UP) || key == 'Z' || key == 'W' || key == 'z' || key == 'w') && (ecran == 1)) {
    haut = 1;
  } else if (((key == CODED && keyCode == DOWN) || key == 'S' || key == 's' && (ecran == 1))) {
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

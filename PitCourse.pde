/* Import */

import gifAnimation.*;
import ddf.minim.*;

/* Variables */

float haut;
float bas;
float vitesse_perso;
float y_perso;
float y_balle;
float y_ballespe;
float x_balle;
float x_ballespe;
float x_fond;
float x_fond2;
float vitesse_balle;
float vitesse_fond;
float espace_highscore;
int chiffrealeatoire;
int ca2;
int score;
int nbre_coeur;
int gameScreen;
String prename;
color play_menu;
color quit_menu;
PImage coeur;
PImage coeur2;
PImage coeur3;
PImage fond;
PImage fond2;
PImage fond_menu;
PImage fond_go;
PImage icon;
PImage icon2;
PFont fontScore;
PFont fontGO;
PFont fontGO2;
PFont fontMenu;
PFont fontVersion;
PFont fontHighscore;
Table table_score;
Minim minim;
AudioPlayer bg;
AudioPlayer menu;
AudioPlayer pouet;
AudioPlayer pouet2;
AudioPlayer pouet3;
AudioPlayer pouet_menu;
AudioPlayer gameover;
Gif persogif;
Gif jewel;
Gif jewelspe;

/* Initialisation */

void setup() {
  /* Ecran */
  frameRate(60);
  size(500,500);  
  
  /* Valeurs varibles */
  score = 0;
  y_perso = 215;
  x_balle = 500;
  x_ballespe = 730;
  y_balle = random(0,460);
  y_ballespe = random(0,460);
  vitesse_perso = 6.0;
  vitesse_balle = 2.5;
  vitesse_fond = 1;
  haut = 0;
  bas = 0;
  nbre_coeur = 3;
  x_fond = 0;
  x_fond2 = 500;
  chiffrealeatoire = 0;
  ca2 = 0;
  gameScreen = 0;
  play_menu = color(255);
  quit_menu = color(255);
  espace_highscore = 0;
  
  /*  Chargements images */
  coeur = loadImage("data/img/heart.png");
  coeur2 = loadImage("data/img/heart.png");
  coeur3 = loadImage("data/img/heart.png");
  fond = loadImage("data/img/fond.png");
  fond2 = loadImage("data/img/fond.png");
  fond_menu = loadImage("data/img/fond_menu.png");
  fond_go = loadImage("data/img/fond_go.png");
  icon = loadImage("data/img/icon.png");
  icon2 = loadImage("data/img/icon2.png");
  surface.setIcon(icon);
  
  /* Musique */
  minim = new Minim(this);
  bg = minim.loadFile("data/sounds/03h49.mp3");
  menu = minim.loadFile("data/sounds/menu.mp3");
  pouet = minim.loadFile("data/sounds/pouet.mp3");
  pouet2 = minim.loadFile("data/sounds/pouet2.mp3");
  pouet3 = minim.loadFile("data/sounds/pouet3.mp3");
  pouet_menu = minim.loadFile("data/sounds/pouet_menu.mp3");
  gameover = minim.loadFile("data/sounds/gameover.mp3");
  
  /* Gifs */
  persogif = new Gif(this, "data/img/bat.gif");
  persogif.play();
  jewel = new Gif(this, "data/img/jewel.gif");
  jewel.play();
  jewelspe = new Gif(this, "data/img/jewel2.gif");
  
  /* Fonts */
  fontScore = createFont("data/font/pixel.ttf",40,true);
  fontGO = createFont("data/font/game.ttf",80,true);
  fontGO2 = createFont("data/font/game.ttf",30,true);
  fontMenu = createFont("data/font/game.ttf",50,true);
  fontVersion = createFont("data/font/pixel.ttf",15,true);
  fontHighscore = createFont("data/font/pixel.ttf",20,true);
  
  /* Table highscore */
  table_score = loadTable("data/highscore/score.csv", "header");
}

/* Fonctionnement */

void draw() {
  /* Si gameScreen est égal à 0, alors c'est le menu, s'il est égal à 1, alors c'est le jeu et s'il est égal à 3, alors c'est le game over */
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
    defilement();
    score();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}

/* Défilement */

void defilement() {
  
  /*Système défilement balle:
  Si l'abscisse de la balle est supérieur ou égal à 0, alors il est soustrait à la vitesse de la balle */
  if(x_balle >= 0) {
    x_balle -= vitesse_balle;
  }
  
  /* Système perte de point:
  Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est supérieur à 1, alors on soustrait 1 au nombre de coeur, on remet l'ordonné (y_balle) à un nombre 
  aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500, on baisse la vitesse de la balle en la multipliant par 0.85 et on joue pouet3 */
  if(x_balle <= 0 && nbre_coeur > 1) {
    nbre_coeur--;
    y_balle = random(0,460);
    x_balle = 500;
    vitesse_balle *= 0.85;
    pouet3.play();
    pouet3.rewind();
    
    /* Système pour mettre les coeurs en noir et blanc */
    if (nbre_coeur == 2) {
      coeur = loadImage("data/img/heart_bw.png");
    }
    if (nbre_coeur == 1) {
      coeur2 = loadImage("data/img/heart_bw.png");
    }
  }
  
  /* Système pour perdre: 
  Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est égal à 1, alors on met le dernier coeur en bw, on arrête le fonctionnement du jeu, gameScreen est
  égal à 2 ce qui veut dire qu'on affiche l'écran de game over*/
  if(x_balle <= 0 && nbre_coeur == 1) {
    gameScreen = 2;
  }
 
  /* Système point:  
  Si l'ordonnée de la balle est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle est supérieure ou égal à l'ordonnée du perso-10 (plus facile) 
  ET si l'abscisse de la balle est égal à 50 alors on on remet l'ordonné (y_balle) à un nombre aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500), on
  ajoute 1 point à la variable score, on joue le son pouet et on met la variable chiffrealéatoire à un chiffre entre 1 et 10 sans virgule*/
  if (y_balle <= y_perso +60 && y_balle >= y_perso-20 && x_balle <= 50) {
    y_balle = random(0,460);
    x_balle = 500;
    score++;
    pouet.play();
    pouet.rewind();
    chiffrealeatoire = (int)random(1,10);
    
    /* Système pour accélérer la balle 1 fois sur 2
    Si le score est pair, alors on accélère */
    if(score%2 == 0) {
      acceleration();
    }
    
    /* Si le chiffre aléatoire est 5, alors on met ca2 (deuxième variable pour eviter qu'elle ne change en plein trajet) égal à lui et on joue l'animation de la balle */
    if(chiffrealeatoire == 5) {
      ca2 = chiffrealeatoire;
      jewelspe.play();
    }
  }
  
  /* Balle spéciale */
  if(ca2 == 5) {
    /*Si l'abscisse de la balle spé est supérieur ou égal à 0, alors il est soustrait à la vitesse de la balle */
    if(x_ballespe >= 0) {
      x_ballespe -= vitesse_balle;
    }
    
    /* Système balle spé:  
    Si l'ordonnée de la balle spé est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle spé est supérieure ou égal à l'ordonnée du perso-10 
    (plus facile) ET si l'abscisse de la balle spé est égal à 50 alors on joue le son pouet2, on augmente la vitesse du perso (c'est le pouvoir), on remet la balle spé à son état
    initial puis on remet ca2 au nouveau chiffre aléatoire */
    if (y_ballespe <= y_perso +60 && y_ballespe >= y_perso-20 && x_ballespe <= 50) {
      pouet2.play();
      pouet2.rewind();
      vitesse_perso *= 1.1;
      vitesse_fond += 1;
      x_ballespe = 730;
      y_ballespe = random(0,460);
      ca2 = chiffrealeatoire;
    }
    
    /* Si Si l'abscisse de la balle spé est inférieur ou égal à 0, alors on joue pouet3, on remet la balle spé à son état initial puis on remet ca2 au nouvea chiffre aléatoire */
    if(x_ballespe <= 0) { 
      pouet3.play();
      pouet3.rewind();
      x_ballespe = 730;
      ca2 = chiffrealeatoire;
      y_ballespe = random(0,460);
    }
  }
  
  /* Système de déplacement avec zone de jeu:
  Si l'ordonné du perso est supérieur ou égal à 0 ET si le l'ordonnée du perso est inférieur ou égal à 430 (taille image) alors on ajoute à l'ordonné du perso le calcul de bas et 
  haut multiplié par la vitesse du perso 
  Cela permet un déplacement fluide*/
  if(y_perso >= 0 && y_perso <= 430) {
    y_perso += (bas - haut) * vitesse_perso;
  }
  
  /* Système de collision*/
  /* Si l'ordonnée du perso est inférieur ou égal à 0 alors on lui ajoute 1 pour ne pas le bloquer en dehors de la zone de jeu */
  if(y_perso <= 0) {
    y_perso++;
  }
  
  /* Si l'ordonnée du perso est supérieur ou égal à 430 (taille image) alors on lui enlève 1 pour ne pas le bloquer en dehors de la zone de jeu */
  if(y_perso >= 430) {
    y_perso--;
  }
}

/* Affichage score */
void score() {
  fill(153,117,194);
  textFont(fontScore);
  text(score, width/2, 15);
  textAlign(CENTER,CENTER);
}

/* Accélération: */
void acceleration() {
  vitesse_balle *= 1.05;
}

/* Les différents écrans de jeu */

/* Menu */

void initScreen() {
  image(fond_menu, 0, 0);
  image(icon2, width/2-128,40);
  menu.play();
  textAlign(CENTER);
  textFont(fontVersion);
  fill(255);
  text("v1.2.0", width/2, height-15);
  textFont(fontMenu);
  fill(play_menu);
  text("Play", width/2, 370);
  fill(quit_menu);
  text("Quit", width/2, 430);
  
  /* Système pour colorier le texte quand on met la souris dessus */
  if (mouseX <= 290 && mouseX >= 210 && mouseY <= 370 && mouseY >= 330) {
    play_menu = color(153,117,194);
  }
  else if (mouseX <= 290 && mouseX >= 210 && mouseY <= 430 && mouseY >= 390) {
    quit_menu = color(153,117,194);
  }
  else {
    play_menu = color(255);
    quit_menu = color(255);
  }
  
  /* Quand on clique sur Play ou sur Quit */
  if (mousePressed) {
    if (mouseX <= 290 && mouseX >= 210 && mouseY <= 370 && mouseY >= 330) {
      gameScreen = 1;
      pouet_menu.play();
      pouet_menu.rewind();
      menu.pause();
      menu.rewind();
      image(fond, x_fond, 0);
      image(fond2, x_fond2, 0);
    }
    if (mouseX <= 290 && mouseX >= 210 && mouseY <= 430 && mouseY >= 390) {
      exit();
    }
  }
}

/* Jeu */

void gameScreen() {
   /* 1ere image qui commence à x_fond (0), qui défile jusqu'à que son abscisse atteigne -500 et qui se remet à ses coords de départ */
   image(fond, x_fond, 0);
   x_fond -= vitesse_fond;
   if (x_fond <= -500) {
     x_fond = 0;  
   }
   
   /* 2nd image qui commence à x_fond2 (500), qui défile jusqu'à que son abscisse (x_fond2) atteigne 0 et qui se remet à ses coords de départ */
   image(fond, x_fond2, 0);
   x_fond2 -= vitesse_fond;
   if (x_fond2 <= 0) {
     x_fond2 = 500;  
   }
   
   /* Sprites */
   
   /* Si ca2 est égal à 5, alors on affiche le sprite de la balle spé. Celle variable est là pour que la balle spé ne disparaisse pas quand la bouclese rejoue */ 
   if(ca2 == 5) {
     image(jewelspe,x_ballespe,y_ballespe);
   }
   
   image(jewel,x_balle,y_balle);
   image(persogif,25,y_perso);
   image(coeur, 462, 5, 32, 32);
   image(coeur2, 425, 5, 32, 32);
   image(coeur3, 388, 5, 32, 32);
   bg.play();
}

/* Game Over */

void gameOverScreen() {
  pouet3.play();
  pouet3.rewind();
  coeur3 = loadImage("data/img/heart_bw.png");
  image(coeur3, 388, 5, 32, 32);
  nbre_coeur = 0;
  image(fond_go, 0, 0);
  textAlign(CENTER);
  fill(153,117,194);
  textFont(fontGO);
  text("GAME OVER", width/2, height/2-150);
  textFont(fontGO2);
  text("Press R to replay or M to go to the main menu", width/2, height/2+220);
  bg.pause();
  gameover.play();
  gameover.rewind();
  menu.play();
  
  /*Fonctionnement table highscore */
  
  /* Nom */
  prename = new Dialog().readString("Quel est ton nom ? (3 lettres)");
  String name = prename.substring(0,3);
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
  for(int i= 0; i <= 10; i += 1){
    row = table_score.getRow(table_score.lastRowIndex()-i);
    String highscore = row.getString("name") + ": " + row.getString("score");
    espace_highscore += 28.5;
    textAlign(CENTER);
    textFont(fontHighscore);
    text(highscore, width/2, 110+espace_highscore);
  }
  espace_highscore = 0;
  noLoop();
}


/* Déplacement */

void keyReleased() {
  if (key == CODED && keyCode == UP) {
      haut = 0;
  } 
  else if (key == CODED && keyCode == DOWN) {
      bas = 0;
  } 
}

void keyPressed() {
  if (key == CODED && keyCode == UP) {
      haut = 1;
  } 
  
  else if (key == CODED && keyCode == DOWN) {
      bas = 1;
  }
  
  /* Système pour rejouer
  Si l'écran de jeu est le Game Over et qu'on appuit sur la touche r, alors la boucle se relance et on remet l'écran de jeu et on fait appel à la procédure rejouer */
  else if (gameScreen == 2 && (key == 'r' || key == 'R')) {
    loop();
    gameScreen = 1;
    rejouer();
    menu.pause();
    menu.rewind();
  }
  
  /* Si l'écran de jeu est le Game Over et qu'on appuit sur la touche m, alors la boucle se relance et on remet l'écran du menu et on fait appel à la procédure rejouer */
  else if (gameScreen == 2 && (key == 'm' || key == 'M')) {
    loop();
    gameScreen = 0;
    rejouer();
  }
}

/* Procédure qui permet de remettre tout correctement avant de rejouer */
void rejouer() {

  nbre_coeur = 3;
  score = 0;
  y_balle = random(0,460);
  y_ballespe = random(0,460);
  y_perso = 215;
  x_fond = 0;
  x_fond2 = 500;
  x_balle = 500;
  x_ballespe = 730;
  vitesse_perso = 6.0;
  vitesse_balle = 2.5;
  vitesse_fond = 1;
  bg.rewind();
  coeur = loadImage("data/img/heart.png");
  coeur2 = loadImage("data/img/heart.png");
  coeur3 = loadImage("data/img/heart.png");
}
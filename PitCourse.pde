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
int chiffrealeatoire;
int ca2;
int score;
int nbre_coeur;
PImage coeur;
PImage coeur2;
PImage coeur3;
PImage fond;
PImage fond2;
PImage icon;
PFont fontScore;
PFont fontGO;
Minim minim;
AudioPlayer bg;
AudioPlayer pouet;
AudioPlayer pouet2;
AudioPlayer pouet3;
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
  
  /*  Chargements images */
  coeur = loadImage("data/img/heart.png");
  coeur2 = loadImage("data/img/heart.png");
  coeur3 = loadImage("data/img/heart.png");
  fond = loadImage("data/img/fond.png");
  fond2 = loadImage("data/img/fond.png");
  icon = loadImage("data/img/icon.png");
  surface.setIcon(icon);
  image(fond, x_fond, 0);
  image(fond2, x_fond2, 0); 
  
  /* Musique */
  minim = new Minim(this);
  bg = minim.loadFile("data/sounds/03h49.mp3");
  bg.play();
  pouet = minim.loadFile("data/sounds/pouet.mp3");
  pouet2 = minim.loadFile("data/sounds/pouet2.mp3");
  pouet3 = minim.loadFile("data/sounds/pouet3.mp3");
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
}

/* Fonctionnement */

void draw() {
  fond();
  dessiner();
  defilement();
  score();
}

/* Fond*/

void fond() {
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
}

/* Sprite */

void dessiner() {
   /* Si ca2 est égal à 5, alors on affiche le sprite de la balle spé. Celle variable est là pour que la balle spé ne disparaisse pas quand la bouclese rejoue */ 
   if(ca2 == 5) {
     image(jewelspe,x_ballespe,y_ballespe);
   }
   image(jewel,x_balle,y_balle);
   image(persogif,25,y_perso);
   image(coeur, 462, 5, 32, 32);
   image(coeur2, 425, 5, 32, 32);
   image(coeur3, 388, 5, 32, 32);
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
  aléatoire entre 0 et 460 (dimension image) et on remet l'abscisse (x_balle) à 500 */
  if(x_balle <= 0 && nbre_coeur > 1) {
    nbre_coeur--;
    y_balle = random(0,460);
    x_balle = 500;
    vitesse_balle *= 0.85;
    pouet3.play();
    pouet3.rewind();
    
    /* Système pour mettre les coeurs en noirs et blancs */
    if (nbre_coeur == 2) {
      coeur = loadImage("data/img/heart_bw.png");
    }
    if (nbre_coeur == 1) {
      coeur2 = loadImage("data/img/heart_bw.png");
    }
  }
  
  /* Système pour perdre: 
  Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est égal à 1, alors on met le dernier coeur en bw, on arrête le fonctionnement du jeu, on affiche 
  un game over puis on arrête la musique de fond pour mettre la musique du game over*/
  if(x_balle <= 0 && nbre_coeur == 1) {
    pouet3.play();
    pouet3.rewind();
    coeur3 = loadImage("data/img/heart_bw.png");
    image(coeur3, 388, 5, 32, 32);
    nbre_coeur = 0;
    fill(0);
    textFont(fontGO);
    text("GAME OVER", width/2, height/2);
    bg.pause();
    gameover.play();
    noLoop();
  }
 
  /* Système point:  
  Si l'ordonnée de la balle est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle est supérieure ou égal à l'ordonnée du perso-10 (plus facile) 
  ET si l'abscisse de la balle est égal à 50 alors on on remet l'ordonné (y_balle) à un nombre aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500), on
  ajoute 1 point à la variable score, on joue le son pouet et on met la variable chiffrealéatoire à un chiffre entre 1 et 10 sans virgule*/
  if (y_balle <= y_perso +60 && y_balle >= y_perso-10 && x_balle <= 50) {
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
    
    /* Système point:  
    Si l'ordonnée de la balle spé est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle spé est supérieure ou égal à l'ordonnée du perso-10 
    (plus facile) ET si l'abscisse de la balle spé est égal à 50 alors on joue le son pouet2, on augmente la vitesse du perso (c le pouvoir), on remet la balle spé à son état
    initial puis on remet ca2 au nouvea chiffre aléatoire */
    if (y_ballespe <= y_perso +60 && y_ballespe >= y_perso-10 && x_ballespe <= 50) {
      pouet2.play();
      pouet2.rewind();
      vitesse_perso *= 1.1;
      vitesse_fond += 1;
      x_ballespe = 730;
      y_ballespe = random(0,460);
      ca2 = chiffrealeatoire;
    }
    
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
  fill(0);
  textFont(fontScore);
  text(score, width/2, 15);
  textAlign(CENTER,CENTER);
}

/* Accélération: */
void acceleration() {
  vitesse_balle *= 1.05;
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
  Si le nombre de coeur est de 0 et qu'on appuit sur la touche r, alors la boucle se relance et on remet les valeurs des vairables à celle de base, on remet les coeurs rouges
  et on remet la musique*/
  else if (nbre_coeur == 0 && key == 'r' ) {
    loop();
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
    bg.play();
    coeur = loadImage("data/img/heart.png");
    coeur2 = loadImage("data/img/heart.png");
    coeur3 = loadImage("data/img/heart.png");
  }
}
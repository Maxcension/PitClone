/* Import */

import processing.sound.*;
import gifAnimation.*;

/* Variables */

float haut;
float bas;
float vitesse_perso;
float y_perso;
float y_balle;
float x_balle;
float x_fond;
float x_fond2;
float vitesse_balle;
int score;
int nbre_coeur;
PImage coeur;
PImage coeur2;
PImage coeur3;
PImage fond;
PImage fond2;
PFont fontScore;
PFont fontScore2;
PFont fontGO;
SoundFile bg;
Gif persogif;
Gif jewel;

/* Initialisation */

void setup() {
  /* Ecran */
  frameRate(60);
  size(500,500);  
  
  /* Valeurs varibles */
  score = 0;
  y_perso = 250;
  x_balle = 500;
  y_balle = random(0,488);
  vitesse_perso = 6.0;
  vitesse_balle = 2.5;
  haut = 0;
  bas = 0;
  nbre_coeur = 3;
  x_fond = 0;
  x_fond2 = 500;
  
  /*  Chargements images */
  coeur = loadImage("assets/img/heart.png");
  coeur2 = loadImage("assets/img/heart.png");
  coeur3 = loadImage("assets/img/heart.png");
  fond = loadImage("assets/img/fond.png");
  fond2 = loadImage("assets/img/fond.png");
  image(fond, x_fond, 0);
  image(fond2, x_fond2, 0); 
  
  /* Musique */
  bg = new SoundFile(this, "E:/processing/TP7/Jeu/assets/sounds/03h49.mp3");
  bg.play();
  
  /* Gifs */
  persogif = new Gif(this, "assets/img/bat.gif");
  persogif.play();
  jewel = new Gif(this, "assets/img/jewel.gif");
  jewel.play();
  
  /* Fonts */
  fontScore = createFont("assets/font/pixel.ttf",40,true);
  fontScore2 = createFont("assets/font/pixel.ttf",45,true);
  fontGO = createFont("assets/font/game.ttf",70,true);
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
   x_fond--;
   if (x_fond <= -500) {
     x_fond = 0;  
   }
   
   /* 2nd image qui commence à x_fond2 (500), qui défile jusqu'à que son abscisse (x_fond2) atteigne 0 et qui se remet à ses coords de départ */
   image(fond, x_fond2, 0);
   x_fond2--;
   if (x_fond2 <= 0) {
     x_fond2 = 500;  
   }
}

/* Sprite */

void dessiner() {
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
    
    /* Système pour mettre les coeurs en noirs et blancs */
    if (nbre_coeur == 2) {
      coeur = loadImage("assets/img/heart_bw.png");
    }
    if (nbre_coeur == 1) {
      coeur2 = loadImage("assets/img/heart_bw.png");
    }
  }
  
  /* Système pour perdre: 
  Si l'abscisse de la balle est inférieur ou égal à 0 et que le nombre de coeur est égal à 1, alors on met le dernier coeur en bw, on arrête le fonctionnement du jeu et on affiche 
  un game over */
  if(x_balle <= 0 && nbre_coeur == 1) {
    coeur3 = loadImage("assets/img/heart_bw.png");
    image(coeur3, 388, 5, 32, 32);
    noLoop();
    textFont(fontGO);
    text("GAME OVER", width/2, height/2);
  }
 
  /* Système point:  
  Si l'ordonnée de la balle est inférieur ou égal à l'ordonnée du perso+60 (dimension image) ET si l'ordonnée de la balle est supérieure ou égal à l'ordonnée du perso ET si 
  l'abscisse de la balle est égal à 50 alors on on remet l'ordonné (y_balle) à un nombre aléatoire entre 0 et 460 (dimension image), on remet l'abscisse (x_balle) à 500 et on
  ajoute 1 point à la variable score*/
  if (y_balle <= y_perso +60 && y_balle >= y_perso && x_balle == 50) {
    y_balle = random(0,460);
    x_balle = 500;
    score++;
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
  textFont(fontScore2);
  text(score, width/2, 20);
  fill(255);
  textFont(fontScore);
  text(score, width/2, 20);
  textAlign(CENTER,CENTER);
}

/*Accélération:
Inutiliser car il fait bugguer le jeu */
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
}
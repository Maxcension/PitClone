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
    if (ca3 == 1) {
      image(jewelspe, x_ballespe, y_ballespe);
      sballe = 1;
    }
    if (ca3 == 2) {
      image(jewelspe2, x_ballespe, y_ballespe);
      sballe = 2;
    }
    if (ca3 == 3) {
      image(jewelspe3, x_ballespe, y_ballespe);
      sballe = 3;
    }
    if (ca3 == 4) {
      image(jewelspe4, x_ballespe, y_ballespe);
      sballe = 4;
    } 
    if (ca3 == 5) {
      image(jewelspe5, x_ballespe, y_ballespe);
    }
  }

  image(jewel, x_balle, y_balle);
  if (sperso == 1) {
    image(perso, 25, y_perso);
  } 
  if (sperso == 2) {
    image(perso2, 25, y_perso);
  } 
  if (sperso == 3) {
    image(perso3, 25, y_perso);
  } 
  if (sperso == 4) {
    image(perso4, 25, y_perso);
  } 
  if (sperso == 5) {
    image(perso5, 25, y_perso);
  } 
  if (sperso == 6) {
    image(perso6, 25, y_perso);
  }
  image(coeur, 462, 5, 32, 32);
  image(coeur2, 425, 5, 32, 32);
  image(coeur3, 388, 5, 32, 32);
  bg.play();

  fill(153, 117, 194);
  textSize(50);
  textFont(font1);
  text(score, width/2, 15);
  textAlign(CENTER, CENTER);

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
      vitesse_bf *= 1.05;
    }

    /* Si le chiffre aléatoire est 5, alors on met ca2 (deuxième variable pour eviter qu'elle ne change en plein trajet) égal à lui */
    if (ca == 5 && ca2 != 5) {
      ca2 = ca;
      ca3 = (int)random(1, 5);
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
      x_ballespe = 730;
      y_ballespe = random(0, 460);
      ca2 = ca;

      if (sballe == 1) {
        if (nbre_coeur < 3) {
          nbre_coeur += 1;
        }
        vitesse_perso *= 1.1;
        pouet2.play();
        pouet2.rewind();

        if (nbre_coeur == 3) {
          coeur = loadImage("img/heart.png");
        }
        if (nbre_coeur == 2) {
          coeur2 = loadImage("img/heart.png");
        }
      } 
      if (sballe == 2) {
        score -= 1;
        pouet4.play();
        pouet4.rewind();
      } 
      if (sballe == 3) {
        score += 2;
        vitesse_perso *= 1.1;
        pouet2.play();
        pouet2.rewind();
      } 
      if (sballe == 4) {
        nbre_coeur -= 1;
        pouet4.play();
        pouet4.rewind();

        if (nbre_coeur == 2) {
          coeur = loadImage("img/heart_bw.png");
        } 
        if (nbre_coeur == 1) {
          coeur2 = loadImage("img/heart_bw.png");
        } 
        if (nbre_coeur == 0) {
          ecran = 2;
        }
      }  
      if (sballe == 5) {
        score += 1;
        vitesse_perso *= 1.2;
        pouet2.play();
        pouet2.rewind();
      }
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

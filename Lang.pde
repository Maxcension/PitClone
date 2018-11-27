void lang(){
  
  image(fond, 0, 0);
  image(fr_flag, 65, 200);
  image(uk_flag, 285, 200);
  menu.play();
  
  if (mouseX <= 215 && mouseX >= 65 && mouseY <= 300 && mouseY >= 200) {
    fr_flag = loadImage("img/fr_flag_2.png");
  } else if (mouseX <= 435 && mouseX >= 285 && mouseY <= 300 && mouseY >= 200) {
    uk_flag = loadImage("img/UK_flag_2.png");
  } else {
    fr_flag = loadImage("img/fr_flag.png");
    uk_flag = loadImage("img/UK_flag.png");
  }

  if (mousePressed) {
    if (mouseX <= 215 && mouseX >= 65 && mouseY <= 300 && mouseY >= 200) {
      lang = 1;
      ecran = 0;
      pouet_menu2.play();
      pouet_menu2.rewind();
    } else if (mouseX <= 435 && mouseX >= 285 && mouseY <= 300 && mouseY >= 200) {
      lang = 0;
      ecran = 0;
      pouet_menu2.play();
      pouet_menu2.rewind();
    }
  }
  
  // Anglais
  if (lang == 0){
    
     // Aide
     dir1 = "Press UP, Z or W to go up"; 
     dir2 = "Press DOWN or S to go down"; 
     cris1 = "This is a basic crystal\n You have to catch it or you'll lose a heart"; 
     cris2 = "This is a special crystal\n You don't have to catch it\n But it gives you a heart if you've lost one \n and it increases Pit's speed"; 
     cris3 = "This one makes you lose a point"; 
     cris4 = "This one gets you two points and\n it increases Pit's speed"; 
     cris5 = "This one makes you lose a heart"; 
     cris6 = "This one gets a point and\n it increases a lot Pit's speed";
     
     // Boutons
     retour = "Return";
     play = "Play";
     quit = "Quit";
     
     // Titres
     help = "Help";
     chskin = "Choose your skin!";
     
     // Skin
     chskin2 = "Actual: ";
     skin1 = "Normal";
     skin2 = "Dark Red";
     skin3 = "Orange";
     skin4 = "Black & White";
     skin5 = "Green";
     skin6 = "Blue";
     
     //Game Over
     nickname = "Nickname? (3 letters)";
     nickname2 = "Error, retry please!\nNickname? (3 letters)";
     go = "Press R to replay or M to go to the main menu";
     
  } else if (lang == 1){
     // Aide
     dir1 = "Presse HAUT, Z ou W pour aller vers le haut"; 
     dir2 = "Presse BAS ou S pour aller vers le bas"; 
     cris1 = "Ceci est un cristal basique\n Tu dois l'attraper sinon tu perds un coeur"; 
     cris2 = "Ceci est un cristal spécial\n Tu n'as pas besoin de l'attraper\n Mais il te donne un coeur si tu en as perdu un";
     cris3 = "Celui-ci te fait perdre un point"; 
     cris4 = "Celui-ci te fait gagner un point\n Il augmente aussi la vitesse de Pit"; 
     cris5 = "Celui_ci te fait perdre un coeur"; 
     cris6 = "Celui-ci te fait gagner deux points\n Il augmente aussi beaucoup la vitesse de Pit";
     
     // Boutons
     retour = "Retour";
     play = "Jouer";
     quit = "Quitter";
     
     // Titres
     help = "Aide";
     chskin = "Choisi ton skin!";
     
     // Skin
     chskin2 = "Actuel: ";
     skin1 = "Normal";
     skin2 = "Rouge foncé";
     skin3 = "Orange";
     skin4 = "Noir et blanc";
     skin5 = "Vert";
     skin6 = "Bleu";
     
     //Game Over
     nickname = "Pseudo? (3 lettres)";
     nickname2 = "Erreur, réessaye s'il te plaît!\nPseudo? (3 lettres)";
     go = "Presse R pour rejouer ou M pour retourner au menu";
  }
  
}

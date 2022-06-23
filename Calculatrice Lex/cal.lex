
%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "cal.h"
 #include "stack.h"
%}


lettre [A-Za-z] 
chiffre [0-9] 
chiff [1-9]
dot "."
qmark "?"
exmark "!"
dollar "$"
op [+\-\*\/]
num [+\-]?{chiffre}+({dot}{chiffre}+)?
var "m"{chiff}{chiffre}* 
delim [ \t\n]
blanc {delim}+


%%
{num}       return(NUM);
{var}       return(VAR);
{exmark}    return(EXMARK);
{dollar}    return(DOLLAR);
{op}        return(OP);
{blanc} {}
{dot}       return(POINT);
{qmark}     return(QMARK);
%%

int main () {
  LexVal valeur = 0;
  States etat = WAIT;
  Stack memoire = newStack();
  Mem mem;//La variable m1 sera en mem[1], la variable m2 en mem[2], etc...
          //PS:La première case mémoire (mem[0]) sera réservée à usage interne comme variable tampon
  float nbr1, nbr2, resultat = 0;//resultat sera le resultat de nbr1+nbr2 ou nbr1-nbr2 ou nbr1*nbr2 ou nbr1/nbr2
  int index;
  while ((valeur = yylex()) !=0) {
    switch (valeur){
    case POINT :
      switch (etat){
      case WAIT : //Quitter l'application
	exit(1);
	break;
      case EVALCMD: //Stocker le résultat du calcul dans mem[0] et l’afficher
	mem[0] = top(memoire);
	printf("%f\n", mem[0]);
	pop(memoire);
	etat = WAIT;
	break;
      default : //Repasser à l'état WAIT
	etat = WAIT; 
	break;
      }
      break;

    case QMARK : //Passer à l'état EVALCMD
      switch (etat) {
      case WAIT :
	etat = EVALCMD;
	break;
      case SKIP : break; //Ne rien faire
      default: //Afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
	break;
      }
      break;

    case EXMARK :
      switch (etat) {
      case WAIT://Passer à l'état STOCMD
	etat = STOCMD;
	break;
      case SKIP: break;//Ne rien faire
      default://afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
	break;
      }
      break;
   
    case DOLLAR :
      switch (etat) {
      case WAIT ://Passer à l'état DISCMD
	etat = DISCMD;
	break;
      case SKIP : break;//Ne rien faire
      default://afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
	break;
      }
      break; 
    
    case OP :
      switch (etat) {
      case EVALCMD ://Evaluer l'application de l'opérateur à ses arguments, mettre à jour la pile
	nbr2 = top(memoire);//on affecte a nbr2 la valeur du sommet de la pile
	pop(memoire);//supression du sommet
	nbr1 = top(memoire);//on affecte a nbr1 la valeur du nouveau sommet de la pile(apres la suppression de l'ancien sommet)
	pop(memoire);//suppression du nouveau sommet
	if (!strcmp(yytext,"+")) resultat = nbr1 + nbr2;
	else if (!strcmp(yytext,"-")) resultat = nbr1 - nbr2;
	else if (!strcmp(yytext,"*")) resultat = nbr1 * nbr2;
	else if (!strcmp(yytext,"/")) resultat = nbr1 / nbr2;
	else printf("erreur\n");
	push(resultat, memoire);//On ajoute le reultat de l'operation dans la pile
	break;
      case SKIP ://Ne rien faire
	break;
      default ://afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
      }
      break;

    case NUM :
      switch (etat) {
      case EVALCMD ://Empiler
	push(atof (yytext), memoire);
	break;
      case SKIP ://Ne rien faire
	break;
      default://Afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
	break;
      }
      break;
      
    case VAR:
      index = atoi(yytext+1);
      switch (etat) {
      case DISCMD ://Afficher
	printf("%f\n", mem[index]);
	break;
      case EVALCMD ://Empiler le valeur de la variable
	push(mem[index], memoire);
	break;
      case SKIP : //Ne rien faire
	break;
      case STOCMD ://Sauver dans la variable la dernière valeur calculée (mem[0])
	mem[index] = mem[0];
	break;
      default://Afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
	break;
      }
      break;
      
    default:  
      switch (etat) {
      case SKIP : break;//Ne rien faire
      default://afficher un message d'erreur puis passer à l'état SKIP
	printf ("erreur\n");
	etat = SKIP;
      }
    }
  }
  free(memoire);//On libere la memoire qui a été réservé pour la pile 'memoire'
  return 0;
}


int yywrap(void)
{
	return 1;
}
int yylex();

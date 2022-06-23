# define SIZE 1024
/*
WAIT	: La calculette est en attente d'une commande
DISCMD : Pour affichage du contenu d'une variable
STOCMD : Pour sauvegarder le dernier résultat calculé (m[0]) dans une variable
EVALCMD : Pour évaluation d'une expression
SKIP : Oubli des erreurs de saisie
*/
typedef enum {
  WAIT, DISCMD, STOCMD, EVALCMD, SKIP
} States;

/*
POINT : Le point qui termine une ligne de commande
QMARK : Le point d'interrogation qui commence une ligne de commande d'évaluation
EXMARK : Le point d'exclamation qui commence une ligne de commande de sauvegarde
DOLLAR : Le dollar ($) qui commence une ligne de commande d'affichage du contenu d'une variable
OP : Un symbole d'opérateur arithmétique
NUM : Une constante entière en notation décimale
VAR : Un nom de variable
*/
typedef enum {
  POINT=1, QMARK, EXMARK, DOLLAR, OP, NUM, VAR
} LexVal;
/*
La variable m1 sera en mem[1], la variable m2 en mem[2], etc...
La première case mémoire (mem[0]) sera réservée à usage interne comme variable tampon
*/
typedef float Mem[SIZE];

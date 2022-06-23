# Calculator-using-LEX-

Calculatrice en utilisant l'outil de génération d'analyseurs lexicaux : LEX
J'ai réalisé une petite calculette permettant d'évaluer des expressions arithmétiques contenant éventuellement des variables. Les expressions seront données en notation polonaise postfixée. Pour pouvoir utiliser des variables, on rajoute à la calculette une instruction permettant d'associer la dernière valeur calculée à une variable (un nom) ainsi qu'une instruction permettant de visualiser le contenu d'une variable.

L'interaction avec la calculette se fait par l'entrée standard (le clavier). Chaque ligne de commandes est terminée par un point (.)
L'utilisateur demande l'évaluation d'une expression en tapant une ligne au format suivant :   ? expr .
L'utilisateur demande à la calculette de mémoriser le résultat de la dernière évaluation en tapant une ligne au format suivant :   ! var .
L'utilisateur demande l'affichage du contenu d'une variable en tapant une ligne au format :   $ var .
L'utilisateur quitte l'application en tapant simplement un point.

En cas d'occurrence d'un caractère erroné, la calculette ignorera tous les caractères lus jusqu'à retrouver le caractère de fin de ligne de commande (le point). Les erreurs dues à des expressions mal formées sont plus délicates à gérer. Nous laissons l'examen et le traitement de ce problème à votre sagacité.

L'interface entre la ligne de commande entrée par l'utilisateur (une suite de caractères) et le processus d'évaluation (et de mémorisation) est réalisé en utilisant l'analyseur lexical Lex
L'analyseur découpe la ligne de commande en unités syntaxiques (ou lexèmes) auxquelles sont associées, dans le processus d'évaluation, un certain nombre d'actions. 

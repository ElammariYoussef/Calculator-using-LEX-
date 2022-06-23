
#include <stdlib.h>
#include <stdio.h>
#include "stack.h"

int nbrElements;

Stack newStack(){//Fonction permettant de créer une nouvelle pile
  nbrElements = 0;
  return calloc(1, sizeof (float));
}

void push(float i, Stack pile) {//Fonction permettant d'ajouter un element à la pile
  pile[nbrElements++] = i;
  pile = realloc (pile, (nbrElements) * sizeof (float));
}

int isEmpty(Stack pile){//Fonction permettant de verifier si la pile est vide ou non
  return (!nbrElements);
}


float top(Stack pile) {//Fonction permettant d'avoir le sommet de la pile
  if (!isEmpty(pile))
    return pile[nbrElements-1];
  else 
    return 0;
}

void pop(Stack pile){//Fonction permettant de supprimer l'element qui est au sommet de la pile
  if (!isEmpty(pile)){
    nbrElements--;
    pile = realloc (pile, (nbrElements+1) * sizeof (float));
  }
}

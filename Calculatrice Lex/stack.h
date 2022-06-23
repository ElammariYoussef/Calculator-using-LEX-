typedef float* Stack;

Stack newStack ();//création d'une nouvelle pile

void push (float i, Stack pile);//empiler

int isEmpty (Stack pile);//Verifier si la pile est vide ou non

float top (Stack pile);//valeur du sommet de pile

void pop (Stack pile);//dépiler

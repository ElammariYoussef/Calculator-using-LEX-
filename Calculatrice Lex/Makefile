calculatrice : stack.o lex.yy.c lex.yy.o stack.c stack.h cal.h cal.lex
	gcc stack.o lex.yy.o -o calculatrice 

stack.o : stack.c stack.h
	gcc -c stack.c

lex.yy.o : lex.yy.c cal.h cal.lex stack.h stack.c stack.o
	gcc -c lex.yy.c 

lex.yy.c : cal.lex cal.h stack.h stack.c stack.o
	lex cal.lex

clean :	
	rm -rf *~
	rm -rf *.o


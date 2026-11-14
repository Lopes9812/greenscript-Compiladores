# Compilar: make     Limpar: make clean
greenscript: greenscript.l
	flex -o lex.yy.c greenscript.l
	gcc -Wall -o greenscript lex.yy.c

clean:
	rm -f lex.yy.c greenscript

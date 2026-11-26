# Compilar o scanner isolado: make
# Integrar com o parser TP2: make tp2 (requer greenscript.y)

.PHONY: all tp2 clean

all: greenscript

greenscript: greenscript.l
	flex -o lex.yy.c greenscript.l
	gcc -Wall -o greenscript lex.yy.c

tp2: greenscript.y greenscript.l
	bison -Wall -d -o greenscript.tab.c greenscript.y
	flex -o lex.yy.c greenscript.l
	gcc -Wall -DGREENSCRIPT_BISON -o greenscript greenscript.tab.c lex.yy.c

clean:
	rm -f lex.yy.c greenscript greenscript.tab.c greenscript.tab.h

%option noyywrap yylineno nounput noinput
%x COMENTARIO_LINHA COMENTARIO_BLOCO

%{
#include <stdio.h>
#include <stdlib.h>

#ifdef GREENSCRIPT_BISON
#include "greenscript.tab.h"

int erro_lexico = 0;
#define TOKEN(codigo, categoria) return codigo
#define PARAR_APOS_ERRO return 0
#else
static unsigned long total_tokens = 0;
static unsigned long total_erros = 0;

static void emitir(const char *categoria);
#define TOKEN(codigo, categoria) emitir(categoria)
#define PARAR_APOS_ERRO ((void) 0)
#endif

static int linha_inicio_comentario = 1;
static void reportar_erro(const char *lexema, int linha);
%}

ID_ESTUFA       EST-[A-Z]{2}[0-9]{2}
ESTUFA_INVALIDA EST-[A-Za-z0-9_]*
INTEIRO         (0|[1-9][0-9]*)
CANDIDATO       [A-Za-z0-9_]+
UTF8CHAR        ([\xC2-\xDF][\x80-\xBF])|(\xE0[\xA0-\xBF][\x80-\xBF])|([\xE1-\xEC\xEE-\xEF][\x80-\xBF]{2})|(\xED[\x80-\x9F][\x80-\xBF])|(\xF0[\x90-\xBF][\x80-\xBF]{2})|([\xF1-\xF3][\x80-\xBF]{3})|(\xF4[\x80-\x8F][\x80-\xBF]{2})

%%

"PROGRAMA"         { TOKEN(PROGRAMA, "PROGRAMA"); }
"LIGAR"            { TOKEN(LIGAR, "LIGAR"); }
"DESLIGAR"         { TOKEN(DESLIGAR, "DESLIGAR"); }
"ABRIR"            { TOKEN(ABRIR, "ABRIR"); }
"FECHAR"           { TOKEN(FECHAR, "FECHAR"); }
"AQUECER"          { TOKEN(AQUECER, "AQUECER"); }
"PARAR"            { TOKEN(PARAR, "PARAR"); }
"REGAR"            { TOKEN(REGAR, "REGAR"); }
"ESPERAR"          { TOKEN(ESPERAR, "ESPERAR"); }
"SE"               { TOKEN(SE, "SE"); }
"SENAO"            { TOKEN(SENAO, "SENAO"); }
"HUMIDADE"         { TOKEN(HUMIDADE, "HUMIDADE"); }
"REPETIR"          { TOKEN(REPETIR, "REPETIR"); }

{ID_ESTUFA}        { TOKEN(ID_ESTUFA, "ID_ESTUFA"); }
{ESTUFA_INVALIDA}  {
                       reportar_erro(yytext, yylineno);
                       PARAR_APOS_ERRO;
                   }
{INTEIRO}          { TOKEN(INTEIRO, "INTEIRO"); }

"<="               { TOKEN(MENOR_IGUAL, "MENOR_IGUAL"); }
">="               { TOKEN(MAIOR_IGUAL, "MAIOR_IGUAL"); }
"=="               { TOKEN(IGUAL, "IGUAL"); }
"!="               { TOKEN(DIFERENTE, "DIFERENTE"); }
"<"                { TOKEN(MENOR, "MENOR"); }
">"                { TOKEN(MAIOR, "MAIOR"); }

"+"                { TOKEN(MAIS, "MAIS"); }
"-"                { TOKEN(MENOS, "MENOS"); }
"*"                { TOKEN(VEZES, "VEZES"); }

"("                { TOKEN(ABRE_PAR, "ABRE_PAR"); }
")"                { TOKEN(FECHA_PAR, "FECHA_PAR"); }
"{"                { TOKEN(ABRE_CHAVETA, "ABRE_CHAVETA"); }
"}"                { TOKEN(FECHA_CHAVETA, "FECHA_CHAVETA"); }
","                { TOKEN(VIRGULA, "VIRGULA"); }
";"                { TOKEN(PONTO_VIRG, "PONTO_VIRG"); }

  /* Os comentários são descartados sem interferir nos tokens adjacentes. */
"#"|"//"           { BEGIN(COMENTARIO_LINHA); }
"/*"               {
                       linha_inicio_comentario = yylineno;
                       BEGIN(COMENTARIO_BLOCO);
                   }

<COMENTARIO_LINHA>[^\n]+ { }
<COMENTARIO_LINHA>\n     { BEGIN(INITIAL); }
<COMENTARIO_LINHA><<EOF>> {
                             BEGIN(INITIAL);
                             return 0;
                         }

<COMENTARIO_BLOCO>"*/"   { BEGIN(INITIAL); }
<COMENTARIO_BLOCO>\n     { }
<COMENTARIO_BLOCO>.      { }
<COMENTARIO_BLOCO><<EOF>> {
                             reportar_erro("/*", linha_inicio_comentario);
                             BEGIN(INITIAL);
                             return 0;
                         }

[ \t\r\n]+         { }

{CANDIDATO}        {
                       reportar_erro(yytext, yylineno);
                       PARAR_APOS_ERRO;
                   }
{UTF8CHAR}         {
                       reportar_erro(yytext, yylineno);
                       PARAR_APOS_ERRO;
                   }
.                  {
                       reportar_erro(yytext, yylineno);
                       PARAR_APOS_ERRO;
                   }

%%

static void reportar_erro(const char *lexema, int linha)
{
#ifdef GREENSCRIPT_BISON
    if (!erro_lexico) {
        printf("ERRO lexical na linha %d: '%s'\n", linha, lexema);
        erro_lexico = 1;
    }
#else
    printf("ERRO lexical na linha %d: '%s'\n", linha, lexema);
    total_erros++;
#endif
}

#ifndef GREENSCRIPT_BISON

static void emitir(const char *categoria)
{
    printf("%d %s %s\n", yylineno, categoria, yytext);
    total_tokens++;
}

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <ficheiro.gs>\n", argv[0]);
        return EXIT_FAILURE;
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    yylex();

    if (fclose(yyin) != 0) {
        perror("Erro ao fechar o ficheiro");
        return EXIT_FAILURE;
    }

    printf("Tokens: %lu | Erros lexicais: %lu\n",
           total_tokens, total_erros);

    return total_erros == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}

#endif

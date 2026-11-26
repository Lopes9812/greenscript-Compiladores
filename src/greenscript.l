%option noyywrap yylineno nounput noinput
%x COMENTARIO_LINHA COMENTARIO_BLOCO

%{
#include <stdio.h>
#include <stdlib.h>

#ifdef GREENSCRIPT_BISON
#include "greenscript.tab.h"
int erro_lexico = 0;
#else
static unsigned long total_tokens = 0;
static unsigned long total_erros = 0;
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

"PROGRAMA" {
#ifdef GREENSCRIPT_BISON
    return PROGRAMA;
#else
    printf("%d PROGRAMA %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"LIGAR" {
#ifdef GREENSCRIPT_BISON
    return LIGAR;
#else
    printf("%d LIGAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"DESLIGAR" {
#ifdef GREENSCRIPT_BISON
    return DESLIGAR;
#else
    printf("%d DESLIGAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"ABRIR" {
#ifdef GREENSCRIPT_BISON
    return ABRIR;
#else
    printf("%d ABRIR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"FECHAR" {
#ifdef GREENSCRIPT_BISON
    return FECHAR;
#else
    printf("%d FECHAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"AQUECER" {
#ifdef GREENSCRIPT_BISON
    return AQUECER;
#else
    printf("%d AQUECER %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"PARAR" {
#ifdef GREENSCRIPT_BISON
    return PARAR;
#else
    printf("%d PARAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"REGAR" {
#ifdef GREENSCRIPT_BISON
    return REGAR;
#else
    printf("%d REGAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"ESPERAR" {
#ifdef GREENSCRIPT_BISON
    return ESPERAR;
#else
    printf("%d ESPERAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"SE" {
#ifdef GREENSCRIPT_BISON
    return SE;
#else
    printf("%d SE %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"SENAO" {
#ifdef GREENSCRIPT_BISON
    return SENAO;
#else
    printf("%d SENAO %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"HUMIDADE" {
#ifdef GREENSCRIPT_BISON
    return HUMIDADE;
#else
    printf("%d HUMIDADE %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"REPETIR" {
#ifdef GREENSCRIPT_BISON
    return REPETIR;
#else
    printf("%d REPETIR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

{ID_ESTUFA} {
#ifdef GREENSCRIPT_BISON
    return ID_ESTUFA;
#else
    printf("%d ID_ESTUFA %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

{ESTUFA_INVALIDA} {
    reportar_erro(yytext, yylineno);
#ifdef GREENSCRIPT_BISON
    return 0;
#endif
}

{INTEIRO} {
#ifdef GREENSCRIPT_BISON
    return INTEIRO;
#else
    printf("%d INTEIRO %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"<=" {
#ifdef GREENSCRIPT_BISON
    return MENOR_IGUAL;
#else
    printf("%d MENOR_IGUAL %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

">=" {
#ifdef GREENSCRIPT_BISON
    return MAIOR_IGUAL;
#else
    printf("%d MAIOR_IGUAL %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"==" {
#ifdef GREENSCRIPT_BISON
    return IGUAL;
#else
    printf("%d IGUAL %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"!=" {
#ifdef GREENSCRIPT_BISON
    return DIFERENTE;
#else
    printf("%d DIFERENTE %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"<" {
#ifdef GREENSCRIPT_BISON
    return MENOR;
#else
    printf("%d MENOR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

">" {
#ifdef GREENSCRIPT_BISON
    return MAIOR;
#else
    printf("%d MAIOR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"+" {
#ifdef GREENSCRIPT_BISON
    return MAIS;
#else
    printf("%d MAIS %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"-" {
#ifdef GREENSCRIPT_BISON
    return MENOS;
#else
    printf("%d MENOS %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"*" {
#ifdef GREENSCRIPT_BISON
    return VEZES;
#else
    printf("%d VEZES %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"(" {
#ifdef GREENSCRIPT_BISON
    return ABRE_PAR;
#else
    printf("%d ABRE_PAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

")" {
#ifdef GREENSCRIPT_BISON
    return FECHA_PAR;
#else
    printf("%d FECHA_PAR %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"{" {
#ifdef GREENSCRIPT_BISON
    return ABRE_CHAVETA;
#else
    printf("%d ABRE_CHAVETA %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"}" {
#ifdef GREENSCRIPT_BISON
    return FECHA_CHAVETA;
#else
    printf("%d FECHA_CHAVETA %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

"," {
#ifdef GREENSCRIPT_BISON
    return VIRGULA;
#else
    printf("%d VIRGULA %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

";" {
#ifdef GREENSCRIPT_BISON
    return PONTO_VIRG;
#else
    printf("%d PONTO_VIRG %s\n", yylineno, yytext);
    total_tokens++;
#endif
}

  /* Comentários são descartados sem interferir nos tokens adjacentes. */
"#"|"//" {
    BEGIN(COMENTARIO_LINHA);
}

"/*" {
    linha_inicio_comentario = yylineno;
    BEGIN(COMENTARIO_BLOCO);
}

<COMENTARIO_LINHA>[^\n]+ { }
<COMENTARIO_LINHA>\n     { BEGIN(INITIAL); }
<COMENTARIO_LINHA><<EOF>> {
    BEGIN(INITIAL);
    return 0;
}

<COMENTARIO_BLOCO>"*/" { BEGIN(INITIAL); }
<COMENTARIO_BLOCO>\n   { }
<COMENTARIO_BLOCO>.    { }
<COMENTARIO_BLOCO><<EOF>> {
    reportar_erro("/*", linha_inicio_comentario);
    BEGIN(INITIAL);
    return 0;
}

[ \t\r\n]+ { }

{CANDIDATO} {
    reportar_erro(yytext, yylineno);
#ifdef GREENSCRIPT_BISON
    return 0;
#endif
}

{UTF8CHAR} {
    reportar_erro(yytext, yylineno);
#ifdef GREENSCRIPT_BISON
    return 0;
#endif
}

. {
    reportar_erro(yytext, yylineno);
#ifdef GREENSCRIPT_BISON
    return 0;
#endif
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

int main(int argc, char *argv[])
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

    fclose(yyin);

    printf("Tokens: %lu | Erros lexicais: %lu\n",
           total_tokens, total_erros);

    return total_erros == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}

#endif

%option noyywrap yylineno
%x COMENTARIO_LINHA COMENTARIO_BLOCO

%{
#include <stdio.h>
#include <stdlib.h>

static unsigned long total_tokens = 0;
static unsigned long total_erros = 0;
static int linha_inicio_comentario = 1;

static void emitir(const char *categoria);
static void erro(void);
static void erro_comentario_nao_terminado(void);
%}

DIGITO      [0-9]
LETRA       [A-Za-z]
CANDIDATO   [A-Za-z0-9_-]+
ID_ESTUFA   EST-[A-Z]{2}[0-9]{2}
INTEIRO     (0|[1-9][0-9]*)
UTF8CHAR    ([\\xC2-\\xDF][\\x80-\\xBF])|([\\xE0-\\xEF][\\x80-\\xBF][\\x80-\\xBF])|([\\xF0-\\xF4][\\x80-\\xBF][\\x80-\\xBF][\\x80-\\xBF])

%%

"LIGAR"             { emitir("LIGAR"); }
"DESLIGAR"          { emitir("DESLIGAR"); }
"ABRIR"             { emitir("ABRIR"); }
"FECHAR"            { emitir("FECHAR"); }
"AQUECER"           { emitir("AQUECER"); }
"PARAR"             { emitir("PARAR"); }
"REGAR"             { emitir("REGAR"); }
"ESPERAR"           { emitir("ESPERAR"); }
"SE"                { emitir("SE"); }
"SENAO"             { emitir("SENAO"); }
"HUMIDADE"          { emitir("HUMIDADE"); }
"REPETIR"           { emitir("REPETIR"); }

{ID_ESTUFA}         { emitir("ID_ESTUFA"); }
{INTEIRO}           { emitir("INTEIRO"); }

"<="                { emitir("MENOR_IGUAL"); }
">="                { emitir("MAIOR_IGUAL"); }
"=="                { emitir("IGUAL"); }
"!="                { emitir("DIFERENTE"); }
"<"                 { emitir("MENOR"); }
">"                 { emitir("MAIOR"); }

"("                 { emitir("ABRE_PAR"); }
")"                 { emitir("FECHA_PAR"); }
"{"                 { emitir("ABRE_CHAVETA"); }
"}"                 { emitir("FECHA_CHAVETA"); }
","                 { emitir("VIRGULA"); }
";"                 { emitir("PONTO_VIRG"); }

/* Comentarios: mudar de estado evita que o conteudo seja tokenizado. */
"#"|"//"            { BEGIN(COMENTARIO_LINHA); }
"/*"                {
                        linha_inicio_comentario = yylineno;
                        BEGIN(COMENTARIO_BLOCO);
                    }

<COMENTARIO_LINHA>\n {
                        BEGIN(INITIAL);
                    }
<COMENTARIO_LINHA>.  { /* Ignorar o conteudo do comentario de linha. */ }
<COMENTARIO_LINHA><<EOF>> {
                        BEGIN(INITIAL);
                        return 0;
                    }

<COMENTARIO_BLOCO>"*/" {
                        BEGIN(INITIAL);
                    }
<COMENTARIO_BLOCO>\n {
                        /* yylineno e atualizado automaticamente pelo Flex. */
                    }
<COMENTARIO_BLOCO>.  { /* Ignorar o conteudo do comentario de bloco. */ }
<COMENTARIO_BLOCO><<EOF>> {
                        erro_comentario_nao_terminado();
                        BEGIN(INITIAL);
                        return 0;
                    }

[ \t\r\n]+        { /* Separadores ignorados. yylineno conta LF. */ }

{CANDIDATO}         { erro(); }
{UTF8CHAR}          { erro(); /* caracter UTF-8 multibyte = um unico erro */ }
.                   { erro(); }

%%

static void emitir(const char *categoria)
{
    printf("%d %s %s\n", yylineno, categoria, yytext);
    total_tokens++;
}

static void erro(void)
{
    printf("ERRO lexical na linha %d: '%s'\n", yylineno, yytext);
    total_erros++;
}

static void erro_comentario_nao_terminado(void)
{
    printf("ERRO lexical na linha %d: '/*'\n", linha_inicio_comentario);
    total_erros++;
}

int main(int argc, char **argv)
{
    if (argc < 2) {
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

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap
%%
[ \t\n] ; // ignore whitespace and newlines

[a-zA-Z]+ { printf("WORD: %s\n", yytext); }

[0-9]+ { printf("NUMBER: %s\n", yytext); }

[.,:;!?()] { printf("SYMBOL: %s\n", yytext); }

\"(\\.|[^\\"])*\" { printf("STRING: %s\n", yytext); }

\/\/.* { /* ignore single-line comments */ }

\/\*[^*]*\*+([^/*][^*]*\*+)*\/ { /* ignore multi-line comments */ }

. { printf("UNKNOWN: %s\n", yytext); }

%%

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen("file.c", "r");
    if (!input_file) {
        printf("Error opening file: %s\n", argv[1]);
        return 1;
    }

    yyin = input_file; // set input stream to file
    yylex(); // perform lexical analysis

    fclose(input_file);
    return 0;
}

%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror (char const *);
%}

%start S
%token ID NUM WHILE LE GE EQ NE
%right '='
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'

%%
S   :   while_statement {
                            printf("Input accepted.\n");
                            exit(0);
                        }
        ;

while_statement :   WHILE '(' condition ')' '{' stmt '}'
                    ;

condition   :   ttype '<' ttype
                | ttype '>' ttype
                | ttype LE ttype
                | ttype GE ttype
                | ttype EQ ttype
                | ttype NE ttype
                ;

stmt    :   stmt stmt
            | expr';'
            ;

ttype   :   ID
            | NUM
            ;

expr    :   ttype '=' expr
            | ttype '=' ttype
            | ttype '+' ttype
            | ttype '-' ttype
            | ttype '*' ttype
            | ttype '/' ttype
            ;
%%

int main()
{
    printf("Enter an expression: ");
    yyparse();
    return (0);
}

int yyerror(char const *s)
{
    return(printf("yyerror %s",s));
}

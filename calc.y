%{
    #include <stdio.h>

    int yylex();
    int yyerror (char const *);
%}

%start S
%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%
S:  E {
		printf("\nResult = %d\n", $$);
		return 0;
	}
    ;
E:  E'+'E { $$ = $1 + $3; }
    | E'-'E { $$ = $1 - $3; }
    | E'*'E { $$ = $1 * $3; }
    | E'/'E { $$ = $1 / $3; }
    | E'%'E { $$ = $1 % $3; }
    | '('E')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;
%%

int main()
{
    yyparse();
    return 0;
}

int yyerror(char const *s)
{
    return(printf("yyerror %s",s));
}

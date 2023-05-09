%option noyywrap

%{
	#include "while.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%%
[ \t\n] ;
while	{return WHILE;}
{digit}+	{return NUM;}
{alpha}({alpha}|{digit})*	{return ID;}
"<="	{return LE;}
">="	{return GE;}
"=="	{return EQ;}
"!="	{return NE;}
.	{return yytext[0];}
%%



%option noyywrap
%{
    #include <iostream>
    int lines = 0, spaces = 0, words = 0, letters = 0, vowels = 0, consonants = 0;
%}

%%
\n { lines++; }

[[:space:]] { spaces++; }

[^ \t\n]+ {
    words++;
    letters += yyleng;
    int i;
    for (i = 0; i < yyleng; i++) {
        char c = yytext[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') 
            {
                vowels++;
            } 
            else if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
            {
                consonants++;
            }
    }
}

.;
%%

int main(int argc, char *argv[])
{
    if (argc != 2) {
        std::cout << "Provide a filename as an argument! Exiting...";
        return 0;
    }
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    std::cout << "Lines: " << lines << "\n";
    std::cout << "Spaces: " << spaces << "\n";
    std::cout << "Words: " << words << "\n";
    std::cout << "Letters: " << letters << "\n";
    std::cout << "Vowels: " << vowels << "\n";
    std::cout << "Consonants: " << consonants << "\n";
    return 0;
}
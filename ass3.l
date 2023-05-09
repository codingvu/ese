%option noyywrap

%{
    #include <iostream>
    #include <string>

    #define DEBUG 0

    std::string ltable[5][30];
    int idxtable[5] = {3, 3, 3, 3, 3};

    int lookup_word(char *word);
    int add_word(char *word);
%}

%%
[a-zA-Z]+ {
        lookup_word(yytext);
}
. ;
\n ;
%%

void init_ltable()
{
    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            ltable[i][j] = "null";
        }
    }
    ltable[0][0] = "adjective";
    ltable[1][0] = "adverb";
    ltable[2][0] = "noun";
    ltable[3][0] = "pronoun";
    ltable[4][0] = "verb";

    // entering predefined words in adjective
    ltable[0][1] = "ambitious";
    ltable[0][2] = "decisive";
    ltable[0][3] = "elegant";

    // entering predefined words in adverb
    ltable[1][1] = "boldly";
    ltable[1][2] = "eagerly";
    ltable[1][3] = "perfectly";

    // entering predefined words in noun
    ltable[2][1] = "actor";
    ltable[2][2] = "building";
    ltable[2][3] = "context";

    // entering predefined words in pronoun
    ltable[3][1] = "mine";
    ltable[3][2] = "yours";
    ltable[3][3] = "ours";

    // entering predefined words in verb
    ltable[4][1] = "accept";
    ltable[4][2] = "behave";
    ltable[4][3] = "guide";
}

int lookup_word(char *word)
{
    std::string category;
    bool found_word = false;

    for (int i = 0; i < 5; i++)
    {
        category = ltable[i][0];
        if (DEBUG)
            std::cout << category << std::endl;
        for (int j = 1; j < 30; j++)
        {
            if (DEBUG)
                std::cout << ltable[i][j] << " " << word << std::endl;
            if (ltable[i][j] == word)
            {
                std::cout << "" << word << " is in the category: " << category << std::endl << std::endl;
                found_word = true;
                return 0;
            }
        }
    }

    if (!found_word)
    {
        printf("Word not found");
    }

    return 0;
}


int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    init_ltable();
    yylex();
    fclose(yyin);
    std::cout << std::endl << "Printing the table" << std::endl;
    for (int i = 0; i < 5; i++)
    {
        std::cout << ltable[i][0] << ": ";
        for (int j = 1; j < 30; j++)
        {
            if (ltable[i][j] != "null")
                std::cout << ltable[i][j] << " ";
        }
        std::cout << std::endl;
    }
    return 0;
}

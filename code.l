/* Gabriel Costa de Oliveira - 190045817 */
/* Leonardo Milomes Vitoriano - 201000379 */
/* Cicero Barrozo Fernandes Filho - 190085819 */
/* Adne Moretti Moreira - 200013181 */

%{
    enum { TRITONGO, DITONGO, RESTO, END_OF_FILE };
    int tritongo = 0, ditongo = 0, resto = 0;
%}

delim        [ \t\n]
ws           {delim}+
letra        [A-Za-z]
vogal        [aeiouAEIOU]
consoante    [^{vogal}]
tritongo     {letra}*{vogal}{vogal}{vogal}{letra}*
ditongo      {letra}*{vogal}{vogal}{letra}*
resto        {letra}+

%%
{ws}        { /* Nenhum valor retornado */ }
{tritongo}  { tritongo++ ; resto++; return TRITONGO;}
{ditongo}   { ditongo++ ; resto++;  return DITONGO;}
{resto}     { resto++  ; return RESTO;} 
<<EOF>>     { return END_OF_FILE; }
%%

// Retorno diferente de zero indica que o scanner deve encerrar ao encontrar EOF
int yywrap() { 
    return 1;
}  

int main()
{
    while (1)
    {
        int token = yylex();
        if (token == END_OF_FILE)
        {
            printf("%d %d %d\n", tritongo, ditongo, resto);
            return 0;
        }
    }
    return 0;
}

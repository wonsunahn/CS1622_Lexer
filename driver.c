/** Code by @author Wonsun Ahn, Fall 2024
 * 
 * The lexer test driver file.
 */

#include <stdio.h>
#include <stdlib.h>
#include "token.h"

extern int yylex();
extern void printStringTable();
extern char *getTokenString(int type);
extern int yyline, yycolumn, yylval;

int main()
{
  int ret;

  yyline = 1;
  yycolumn = 1;
  printf("Line\tColumn\t%-16s\tLexeme\n", "Token");
  while (1)
  {
    switch (ret = yylex())
    {
    case ICONSTnum:
    case SCONSTnum:
    case IDnum:
      printf("%d\t%d\t%-16s\t%d\n", yyline, yycolumn, getTokenString(ret), yylval);
      break;
    default:
      printf("%d\t%d\t%-16s\n", yyline, yycolumn, getTokenString(ret));
      break;
    case 0:
      printf("%d\t%d\t%-16s\n", yyline, yycolumn, getTokenString(ret)); /* end of file incurred */
      printf("\nString Table : ");
      printStringTable();
      return 0;
    }
  }
  return 0;
}

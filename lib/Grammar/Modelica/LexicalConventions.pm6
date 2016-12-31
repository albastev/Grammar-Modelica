#!perl6

use v6;

unit role Grammar::Modelica::LexicalConventions;

token IDENT {[<NONDIGIT>[<DIGIT>||<NONDIGIT>]*]||<Q-IDENT>}

token Q-IDENT {<[']>[<Q-CHAR>||<S-ESCAPE>]+<[']>}

regex NONDIGIT { <[A..Za..z_]> }

regex STRING { '"' [ <S-CHAR> || <S-ESCAPE> ]* '"'}

token S-CHAR {<[ \x[0000] .. \x[10FFFF] ] - [ " \\ ]>}

token Q-CHAR {<NONDIGIT>||<DIGIT>||<[!$%&()*+,./:;<>=?@[\]^{}~#|-]>||" "}

regex S-ESCAPE {'\\\'' || '\\"' || '\\?' || '\\\\' ||
           '\\a' || '\\b' || '\\f' || '\\n' || '\\r' || '\\t' || '\\v'  }

regex DIGIT { <[0..9]> }

#UNSIGNED_INTEGER = DIGIT { DIGIT }
regex UNSIGNED_INTEGER {<DIGIT>+}

#UNSIGNED_NUMBER = UNSIGNED_INTEGER [ "." [ UNSIGNED_INTEGER ] ]
#  [ ( "e" | "E" ) [ "+" | "-" ] UNSIGNED_INTEGER ]
regex UNSIGNED_NUMBER {<UNSIGNED_INTEGER>['.'<UNSIGNED_INTEGER>?]?[<[eE]><[+-]>?<UNSIGNED_INTEGER>]?}

regex comment {['//'.*?$$]||['/*'.*?'*/']}

token ws { \s*<comment>*\s* }

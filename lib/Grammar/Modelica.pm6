#!perl6

use v6;
use Grammar::Modelica::LexicalConventions;

unit grammar Grammar::Modelica does Grammar::Modelica::LexicalConventions;

rule TOP {^ <within><class-def>* $}

regex within { 'within' <ws>+ <name> <ws>* ';' }

rule name {'.'?<IDENT>['.'?<IDENT>]?}

rule bgs { 'cou!!asdfafsd!!'  }

rule class-def { <bgs>? $<final>='final'? <class-definition> ';' }

rule class-definition { $<encapsulated>='encapsulated'? <class-prefixes> <class-specifier> }

rule class-prefixes { $<partial>='partial'? ( 'class' || 'model' || [ 'operator'? 'record' ] ||
  'block' || [ 'expandable'? 'connector'] || 'type' || 'package' || [[ 'pure' | 'impure' ]? 'operator'? 'function'] ||
  'operator'
)  }

rule class-specifier {<name>}

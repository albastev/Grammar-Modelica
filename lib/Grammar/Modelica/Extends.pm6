#!perl6

use v6;

unit role Grammar::Modelica::Extends;

rule extends_clause {
  'extends' <name> <class_modification>? <annotation>?
}

rule constraining_clause {
  'constrainedby' <name> <class_modification>?
}
